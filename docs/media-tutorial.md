# Media tutorial: play, decode and encode on the CIX P1

Practical guide for the CIX Sky1 (CD8180) board. All commands were tested on
the Lenovo LACM-MN101 with kernel 7.0.0-38-cix and Ubuntu 26.04.

Measurements and the capability list: [media.md](media.md).

## 1. What you need

| Item | Check | Fix |
| --- | --- | --- |
| Kernel driver | `lsmod \| grep amvx` | Use a kernel with the CIX VPU driver |
| Device nodes | `ls /dev/video*` | Add your user to the `video` group |
| GStreamer | `gst-inspect-1.0 v4l2h264dec` | `apt install gstreamer1.0-plugins-bad gstreamer1.0-libav` |
| Parsers | `gst-inspect-1.0 h264parse` | Same package as above |
| ffmpeg | `ffmpeg -decoders \| grep v4l2m2m` | `apt install ffmpeg` |
| Tools | `v4l2-ctl --list-devices` | `apt install v4l-utils` |
| Display output | a running Wayland session | Run the shell as the desktop user |

One command installs the common set:

```
sudo apt update
sudo apt install -y gstreamer1.0-plugins-bad gstreamer1.0-libav \
	ffmpeg v4l-utils vainfo clinfo
```

The user must be in the `video` group for /dev/video* and /dev/dri.

```
sudo usermod -aG video,render "$USER"
```

Log out and in again after this change.

## 2. Check the stack

```
v4l2-ctl --list-devices                       # M2M encode and decode nodes
v4l2-ctl -d /dev/video0 --list-formats-out    # decoders: H264, HEVC, AV1, ...
v4l2-ctl -d /dev/video2 --list-formats        # capture: NV12, AFBC formats
gst-inspect-1.0 | grep -E "v4l2(h264|h265|av1|vp9|vp8|jpeg|mpeg)"
ffmpeg -hide_banner -decoders | grep v4l2m2m
ffmpeg -hide_banner -encoders | grep v4l2m2m
vainfo                                        # fails without the CIX driver
clinfo | grep -E "Device Name|Compute units"
```

Result on this board: /dev/video0 to /dev/video3, `amvx` driver, eight
decode formats, AFBC and NV12 capture formats, and a Mali-G720 GPU with
OpenCL 3.0.

## 3. Play a file with hardware decode

Wayland session, hardware decode, GL output:

```
export XDG_RUNTIME_DIR=/run/user/1000
export WAYLAND_DISPLAY=wayland-0

gst-launch-1.0 filesrc location=clip.mp4 ! qtdemux ! h264parse \
	! v4l2h264dec ! glimagesink
```

For a file with its own demuxer, `decodebin` picks the hardware decoder:

```
gst-launch-1.0 filesrc location=clip.mp4 ! decodebin ! glimagesink
```

Choose the codec element for other formats: `v4l2h265dec`, `v4l2av1dec`
(needs `ivfparse ! av1parse` for IVF), `v4l2vp9dec`, `v4l2vp8dec`,
`v4l2mpeg2dec`, `v4l2mpeg4dec`, `v4l2h263dec`, `v4l2jpegdec`.

Notes:

1. Keep output on the GPU path. `glimagesink` in a Wayland session avoids a
   copy through the CPU.
2. `mpv --hwdec=auto` does not work here. mpv uses the VA-API path, and the
   CIX VA-API driver is not installed. Use GStreamer for hardware decode.
3. To check the decoded format, add a capsfilter:
   `! video/x-raw,format=NV12 ! fakesink`.

## 4. Decode and measure

ffmpeg with the V4L2 wrapper, one line per codec:

```
ffmpeg -c:v h264_v4l2m2m -i clip.h264 -f null -
ffmpeg -c:v hevc_v4l2m2m -i clip.h265 -f null -
ffmpeg -c:v vp9_v4l2m2m  -i clip.webm -f null -
ffmpeg -c:v vp8_v4l2m2m  -i clip.webm -f null -
ffmpeg -c:v mpeg2_v4l2m2m -i clip.m2v -f null -
```

Measure wall time, CPU time and memory:

```
ffmpeg -hide_banner -benchmark -c:v h264_v4l2m2m -i clip.h264 -f null -
/usr/bin/time -v ffmpeg -c:v h264_v4l2m2m -i clip.h264 -f null -
```

The `bench:` line gives `utime`, `stime` and `rtime`. Frames per second is
frame count divided by `rtime`. CPU cores used is `(utime + stime) / rtime`.

Compare against software decode with `-c:v h264` and `-c:v hevc`.

Write decoded frames to disk when you need the pixels:

```
gst-launch-1.0 filesrc location=clip.mp4 ! qtdemux ! h264parse \
	! v4l2h264dec ! video/x-raw,format=NV12 ! filesink location=frames.nv12
```

300 frames of 1080p NV12 are about 933 MB, so check free space.

## 5. Encode

GStreamer, H.264 with a bitrate:

```
gst-launch-1.0 videotestsrc num-buffers=300 ! \
	video/x-raw,width=1920,height=1080,format=NV12 ! \
	v4l2h264enc extra-controls="controls,video_bitrate=4000000" ! \
	h264parse ! matroskamux ! filesink location=out.mkv
```

Other encoders: `v4l2h265enc`, `v4l2vp9enc`, `v4l2vp8enc`, `v4l2jpegenc`.

Common extra controls, from the CIX multimedia guide:

| Control | Use |
| --- | --- |
| `video_bitrate` | Target bitrate in bits per second |
| `video_gop_size` | GOP length. Example: 300. |
| `h264_i_frame_qp_value` | I frame QP, 0 to 51. 0 lets the encoder decide. |
| `h264_p_frame_qp_value` | P frame QP, 0 to 51 |
| `h264_b_frame_qp_value` | B frame QP, 0 to 51 |
| `force_key_frame` | Force one key frame at run time |
| `h264_minimum_qp_value` | Lower QP bound for rate control |
| `h264_maximum_qp_value` | Upper QP bound for rate control |

Set several controls in one string:

```
extra-controls="controls,video_bitrate=2000000,video_gop_size=300"
```

ffmpeg encodes through the same wrapper:

```
ffmpeg -f lavfi -i testsrc2=size=1920x1080:rate=60 -t 10 -pix_fmt nv12 \
	-c:v h264_v4l2m2m -b:v 8M out.h264
ffmpeg -f lavfi -i testsrc2=size=1920x1080:rate=60 -t 10 -pix_fmt nv12 \
	-c:v hevc_v4l2m2m -b:v 8M out.h265
```

Input must be NV12. FFmpeg has no V4L2 JPEG encoder; use `v4l2jpegenc` from
GStreamer for JPEG.

## 6. Images

The VPU decodes JPEG and MJPEG up to 7680x4320@30.

```
timeout 30 gst-launch-1.0 -q filesrc location=photo.jpg \
	! jpegparse ! v4l2jpegdec ! video/x-raw,format=NV12 ! fakesink
```

Always use a timeout. The decoder hung in one of ten runs in the test.

```
gst-launch-1.0 videotestsrc num-buffers=30 ! \
	video/x-raw,width=1920,height=1080,format=NV12 ! \
	v4l2jpegenc ! filesink location=out.mjpeg
```

## 7. Many streams at once

The VPU handles 16 streams of 1080p60 or 60 streams of 720p25 for H.264,
HEVC, AV1 and VP9. Start several decoders in separate processes, or use one
pipeline per stream:

```
for i in $(seq 1 10); do
	gst-launch-1.0 -q filesrc location=clip.mp4 ! qtdemux ! h264parse \
		! v4l2h264dec ! fakesink &
done
wait
```

Watch the CPU use. Hardware decode keeps it low. If the streams stutter,
lower the count or the resolution.

## 8. Monitor the VPU

The driver has a debug interface:

```
sudo ls /sys/kernel/debug/amvx/log/group
sudo cat /sys/kernel/debug/amvx/log/group/error/severity
echo 3 | sudo tee /sys/kernel/debug/amvx/log/group/error/severity
sudo cat /sys/kernel/debug/amvx/log/drain/dmesg
```

Severity levels: 0 panic, 1 error, 2 warning, 3 info, 4 debug, 5 verbose.

`/sys/kernel/debug/amvx/log/group/perf/` also has `utilization`,
`realtime_fps` and `average_fps`. On this image the counters answered
`VPU Performance Monitor is OFF` even after a write to `enable`. Use the
external method from section 4 instead.

## 9. Troubleshooting

| Symptom | Cause | Fix |
| --- | --- | --- |
| `no element "h264parse"` | Parsers missing | Install `gstreamer1.0-plugins-bad` |
| `vaInitialize failed` | CIX VA-API driver missing | Use GStreamer V4L2 elements |
| `Permission denied` on /dev/video0 | User not in the `video` group | `usermod -aG video,render` |
| `Could not initialize canvas` | No display session | Set `WAYLAND_DISPLAY` and `XDG_RUNTIME_DIR` |
| Pipeline hangs on a JPEG | Known `v4l2jpegdec` issue | Wrap in `timeout` |
| VP9 in WebM fails to link | Demuxer and parser mismatch | Decode with ffmpeg `vp9_v4l2m2m` |
| `no element "vp8parse"` | Parser missing in this image | Use ffmpeg `vp8_v4l2m2m` |
| Encoder rejects input | Wrong pixel format | Feed NV12 |

## 10. Reference

| Source | Content |
| --- | --- |
| `media.md` | Measured numbers and capability table |
| `../media/stack/v4l2.txt` | Device and format list of this board |
| `../media/stack/gst-elements.txt` | Full GStreamer element list |
| `../media/tools/run-media-bench.sh` | The measurement script |
| CIX-P1 多媒体开发指导手册 | GStreamer, Codec2, codec matrix |
| CIX-P1-VPU 开发指导手册 | Driver interface and streams |
| CIX-P1-VAAPI 开发指导手册 | VA-API stack |
| CIX-P1-Linux GPU 开发使用手册 | GPU stack, Zink, AFBC |

The CIX documents are vendor material and are not stored in this repository.
