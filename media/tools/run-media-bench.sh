#!/bin/bash
# Media benchmark for the CIX P1 (Sky1) board.
# Run as a user with passwordless sudo. Run time is about 10 minutes.
# Writes /tmp/cix-media.tgz and /tmp/cix-media2.tgz.

set -u

OUT=${OUT:-/tmp/cix-media}
OUT2=${OUT2:-/tmp/cix-media2}
SAMPLE_URL=https://test-videos.co.uk/vids/jellyfish/mp4/h264/1080/Jellyfish_1080_10s_5MB.mp4

rm -rf "$OUT" "$OUT2"
mkdir -p "$OUT"/{clips,log,stack} "$OUT2"/{log,gst}

echo "step 1: stack description"
{
	echo "== v4l2 devices"; v4l2-ctl --list-devices
	for d in /dev/video0 /dev/video1 /dev/video2 /dev/video3; do
		echo "== $d"
		v4l2-ctl -d "$d" --info
		v4l2-ctl -d "$d" --list-formats-out
		v4l2-ctl -d "$d" --list-formats
	done
} >"$OUT/stack/v4l2.txt" 2>&1
gst-inspect-1.0 >"$OUT/stack/gst-elements.txt" 2>&1
ffmpeg -hide_banner -hwaccels >"$OUT/stack/ffmpeg-hwaccels.txt" 2>&1
ffmpeg -hide_banner -decoders >"$OUT/stack/ffmpeg-decoders.txt" 2>&1
ffmpeg -hide_banner -encoders >"$OUT/stack/ffmpeg-encoders.txt" 2>&1
vainfo >"$OUT/stack/vainfo.txt" 2>&1
clinfo >"$OUT/stack/clinfo.txt" 2>&1
{
	echo "== modules"; lsmod | grep -E "amvx|mali|v4l2|mvx"
	echo "== dri"; ls -l /dev/dri
	echo "== debugfs amvx"; sudo -n ls -R /sys/kernel/debug/amvx 2>/dev/null | head -30
} >"$OUT/stack/kernel.txt" 2>&1

echo "step 2: test clips"
FF="ffmpeg -hide_banner -benchmark -y"
$FF -f lavfi -i testsrc2=size=1920x1080:rate=60 -t 10 -pix_fmt nv12 \
	-c:v h264_v4l2m2m -b:v 8M "$OUT/clips/h264-1080p60.h264" \
	>"$OUT/log/encode-h264-1080p60.txt" 2>&1 \
	|| $FF -f lavfi -i testsrc2=size=1920x1080:rate=60 -t 10 -c:v libx264 -preset ultrafast \
		"$OUT/clips/h264-1080p60.h264" >>"$OUT/log/encode-h264-1080p60.txt" 2>&1
$FF -f lavfi -i testsrc2=size=1920x1080:rate=60 -t 10 -pix_fmt nv12 \
	-c:v hevc_v4l2m2m -b:v 8M "$OUT/clips/h265-1080p60.h265" \
	>"$OUT/log/encode-h265-1080p60.txt" 2>&1 \
	|| $FF -f lavfi -i testsrc2=size=1920x1080:rate=60 -t 10 -c:v libx265 -preset ultrafast \
		"$OUT/clips/h265-1080p60.h265" >>"$OUT/log/encode-h265-1080p60.txt" 2>&1
$FF -f lavfi -i testsrc2=size=3840x2160:rate=30 -t 10 -pix_fmt nv12 \
	-c:v h264_v4l2m2m -b:v 25M "$OUT/clips/h264-4k30.h264" \
	>"$OUT/log/encode-h264-4k30.txt" 2>&1 \
	|| $FF -f lavfi -i testsrc2=size=3840x2160:rate=30 -t 10 -c:v libx264 -preset ultrafast \
		"$OUT/clips/h264-4k30.h264" >>"$OUT/log/encode-h264-4k30.txt" 2>&1
$FF -f lavfi -i testsrc2=size=640x360:rate=30 -t 2 -c:v libvpx-vp9 -deadline realtime \
	-cpu-used 8 "$OUT/clips/vp9-360p30.webm" >"$OUT/log/encode-vp9.txt" 2>&1
$FF -f lavfi -i testsrc2=size=640x360:rate=30 -t 2 -c:v libaom-av1 -cpu-used 8 \
	"$OUT/clips/av1-360p30.ivf" >"$OUT/log/encode-av1.txt" 2>&1
$FF -f lavfi -i testsrc2=size=3840x2160 -frames:v 1 -q:v 2 "$OUT/clips/photo-4k.jpg" \
	>"$OUT/log/encode-jpeg.txt" 2>&1
mkdir -p "$OUT/clips/jpeg"
for i in $(seq 1 20); do cp "$OUT/clips/photo-4k.jpg" "$OUT/clips/jpeg/img$i.jpg"; done

echo "step 3: ffmpeg decode, hardware against software"
run_ff() {
	local name="$1" decoder="$2" input="$3"
	for i in 1 2 3; do
		/usr/bin/time -f "wall=%e cpu=%P" -o "$OUT2/log/$name.time$i" \
			ffmpeg -hide_banner -benchmark -y -c:v "$decoder" -i "$input" \
			-f null - >"$OUT2/log/$name.run$i.txt" 2>&1
	done
}
run_ff hw-h264-1080p h264_v4l2m2m "$OUT/clips/h264-1080p60.h264"
run_ff sw-h264-1080p h264 "$OUT/clips/h264-1080p60.h264"
run_ff hw-hevc-1080p hevc_v4l2m2m "$OUT/clips/h265-1080p60.h265"
run_ff sw-hevc-1080p hevc "$OUT/clips/h265-1080p60.h265"
run_ff hw-h264-4k h264_v4l2m2m "$OUT/clips/h264-4k30.h264"
run_ff hw-vp9-360p vp9_v4l2m2m "$OUT/clips/vp9-360p30.webm"

echo "step 4: real world clip"
if timeout 60 curl -fsL -o "$OUT/clips/jellyfish-1080p-h264.mp4" "$SAMPLE_URL" \
		>"$OUT2/log/download.txt" 2>&1; then
	run_ff hw-h264-real h264_v4l2m2m "$OUT/clips/jellyfish-1080p-h264.mp4"
	run_ff sw-h264-real h264 "$OUT/clips/jellyfish-1080p-h264.mp4"
fi

echo "step 5: GStreamer"
sudo -n apt-get install -y gstreamer1.0-plugins-bad gstreamer1.0-libav >/dev/null 2>&1
gst_run() {
	local name="$1"
	shift
	/usr/bin/time -f "wall=%e cpu=%P" -o "$OUT2/gst/$name.time" "$@" >"$OUT2/gst/$name.txt" 2>&1
}
gst_run gst-v4l2h264dec gst-launch-1.0 -q filesrc location="$OUT/clips/h264-1080p60.h264" \
	! h264parse ! v4l2h264dec ! fakesink
gst_run gst-avdec-h264 gst-launch-1.0 -q filesrc location="$OUT/clips/h264-1080p60.h264" \
	! h264parse ! avdec_h264 ! fakesink
gst_run gst-v4l2h265dec gst-launch-1.0 -q filesrc location="$OUT/clips/h265-1080p60.h265" \
	! h265parse ! v4l2h265dec ! fakesink
gst_run gst-v4l2jpegdec timeout 30 gst-launch-1.0 -q filesrc \
	location="$OUT/clips/photo-4k.jpg" ! jpegparse ! v4l2jpegdec ! fakesink
gst_run gst-jpegdec-sw timeout 30 gst-launch-1.0 -q filesrc \
	location="$OUT/clips/photo-4k.jpg" ! jpegparse ! jpegdec ! fakesink
{
	echo "== av1 hardware decode"
	/usr/bin/time -f "wall=%e cpu=%P" timeout 30 gst-launch-1.0 -q filesrc \
		location="$OUT/clips/av1-360p30.ivf" ! ivfparse ! av1parse ! v4l2av1dec ! fakesink
	echo "== jpeg hardware encode, 30 frames"
	/usr/bin/time -f "wall=%e cpu=%P" timeout 60 gst-launch-1.0 -q videotestsrc num-buffers=30 \
		! video/x-raw,width=1920,height=1080,format=NV12 ! v4l2jpegenc ! fakesink
	echo "== h264 hardware encode, 300 frames"
	/usr/bin/time -f "wall=%e cpu=%P" timeout 60 gst-launch-1.0 -q videotestsrc num-buffers=300 \
		! video/x-raw,width=1920,height=1080,format=NV12 ! v4l2h264enc ! h264parse ! fakesink
} >"$OUT2/log/codecs.txt" 2>&1

echo "packing"
tar czf /tmp/cix-media.tgz -C /tmp cix-media
tar czf /tmp/cix-media2.tgz -C /tmp cix-media2
ls -l /tmp/cix-media.tgz /tmp/cix-media2.tgz
echo done
