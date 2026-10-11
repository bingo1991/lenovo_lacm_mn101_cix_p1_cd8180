# 多媒体使用教程：CIX P1 播放、解码与编码

面向 CIX Sky1（CD8180）整机的实操指南。所有命令均在联想 LACM-MN101、
内核 7.0.0-38-cix、Ubuntu 26.04 上验证过。

性能数据与能力清单见 [media.md](media.md)。

## 1. 前置条件

| 项目 | 检查命令 | 处理办法 |
| --- | --- | --- |
| 内核驱动 | `lsmod \| grep amvx` | 使用带 CIX VPU 驱动的内核 |
| 设备节点 | `ls /dev/video*` | 把用户加入 `video` 组 |
| GStreamer | `gst-inspect-1.0 v4l2h264dec` | `apt install gstreamer1.0-plugins-bad gstreamer1.0-libav` |
| 解析器 | `gst-inspect-1.0 h264parse` | 同上 |
| ffmpeg | `ffmpeg -decoders \| grep v4l2m2m` | `apt install ffmpeg` |
| 工具 | `v4l2-ctl --list-devices` | `apt install v4l-utils` |
| 显示输出 | 有正在运行的 Wayland 会话 | 以桌面用户身份执行 |

一次装齐：

```
sudo apt update
sudo apt install -y gstreamer1.0-plugins-bad gstreamer1.0-libav \
	ffmpeg v4l-utils vainfo clinfo
sudo usermod -aG video,render "$USER"    # 之后需重新登录
```

## 2. 检查能力

```
v4l2-ctl --list-devices                       # M2M 编解码节点
v4l2-ctl -d /dev/video0 --list-formats-out    # 解码：H264/HEVC/AV1/VP9...
v4l2-ctl -d /dev/video2 --list-formats        # 输出：NV12、AFBC 格式
gst-inspect-1.0 | grep -E "v4l2(h264|h265|av1|vp9|vp8|jpeg|mpeg)"
ffmpeg -hide_banner -decoders | grep v4l2m2m
vainfo                                        # 缺 CIX 驱动时会失败
clinfo | grep -E "Device Name|Compute units"
```

本机结果：/dev/video0–3、`amvx` 驱动、8 种解码格式、支持 AFBC 与 NV12 输出，
GPU 为 Mali-G720，OpenCL 3.0。

## 3. 硬件解码播放

Wayland 会话下硬件解码并直接显示：

```
export XDG_RUNTIME_DIR=/run/user/1000
export WAYLAND_DISPLAY=wayland-0

gst-launch-1.0 filesrc location=clip.mp4 ! qtdemux ! h264parse \
	! v4l2h264dec ! glimagesink
```

交给 `decodebin` 自动选择：

```
gst-launch-1.0 filesrc location=clip.mp4 ! decodebin ! glimagesink
```

其他格式换元件名：`v4l2h265dec`、`v4l2av1dec`（IVF 需先 `ivfparse ! av1parse`）、
`v4l2vp9dec`、`v4l2vp8dec`、`v4l2mpeg2dec`、`v4l2mpeg4dec`、`v4l2h263dec`、
`v4l2jpegdec`。

注意：

1. 输出尽量留在 GPU 路径，Wayland 下 `glimagesink` 可避免 CPU 拷贝。
2. `mpv --hwdec=auto` 在本机不可用：mpv 走 VA-API，而 CIX 的 VA-API 用户态
   驱动未安装。硬解请走 GStreamer。
3. 想确认解码输出格式，加 capsfilter：`! video/x-raw,format=NV12 ! fakesink`。

## 4. 解码与测量

ffmpeg 的 V4L2 包装器，按编码格式选择：

```
ffmpeg -c:v h264_v4l2m2m -i clip.h264 -f null -
ffmpeg -c:v hevc_v4l2m2m -i clip.h265 -f null -
ffmpeg -c:v vp9_v4l2m2m  -i clip.webm -f null -
ffmpeg -c:v vp8_v4l2m2m  -i clip.webm -f null -
ffmpeg -c:v mpeg2_v4l2m2m -i clip.m2v -f null -
```

测量耗时与 CPU：

```
ffmpeg -hide_banner -benchmark -c:v h264_v4l2m2m -i clip.h264 -f null -
/usr/bin/time -v ffmpeg -c:v h264_v4l2m2m -i clip.h264 -f null -
```

`bench:` 行给出 `utime`、`stime`、`rtime`：帧率 = 帧数 / rtime，
占用核数 = (utime + stime) / rtime。软解对照把编码器换成 `-c:v h264`、
`-c:v hevc`。

导出解码后的原始帧：

```
gst-launch-1.0 filesrc location=clip.mp4 ! qtdemux ! h264parse \
	! v4l2h264dec ! video/x-raw,format=NV12 ! filesink location=frames.nv12
```

1080p NV12 每帧约 3.1 MB，300 帧约 933 MB，先确认磁盘空间。

## 5. 编码

GStreamer 编码 H.264 并指定码率：

```
gst-launch-1.0 videotestsrc num-buffers=300 ! \
	video/x-raw,width=1920,height=1080,format=NV12 ! \
	v4l2h264enc extra-controls="controls,video_bitrate=4000000" ! \
	h264parse ! matroskamux ! filesink location=out.mkv
```

其他编码元件：`v4l2h265enc`、`v4l2vp9enc`、`v4l2vp8enc`、`v4l2jpegenc`。

常用参数（取自 CIX 多媒体手册）：

| 参数 | 说明 |
| --- | --- |
| `video_bitrate` | 目标码率，单位 bit/s |
| `video_gop_size` | GOP 长度，例如 300 |
| `h264_i_frame_qp_value` | I 帧 QP，0–51，0 表示由编码器决定 |
| `h264_p_frame_qp_value` | P 帧 QP，0–51 |
| `h264_b_frame_qp_value` | B 帧 QP，0–51 |
| `force_key_frame` | 运行时强制插入关键帧 |
| `h264_minimum_qp_value` / `h264_maximum_qp_value` | 码率控制的 QP 上下限 |

多个参数写在同一个字符串里：

```
extra-controls="controls,video_bitrate=2000000,video_gop_size=300"
```

ffmpeg 走同一套包装器：

```
ffmpeg -f lavfi -i testsrc2=size=1920x1080:rate=60 -t 10 -pix_fmt nv12 \
	-c:v h264_v4l2m2m -b:v 8M out.h264
ffmpeg -f lavfi -i testsrc2=size=1920x1080:rate=60 -t 10 -pix_fmt nv12 \
	-c:v hevc_v4l2m2m -b:v 8M out.h265
```

输入必须是 NV12。ffmpeg 没有 V4L2 JPEG 编码器，JPEG 用 GStreamer 的
`v4l2jpegenc`。

## 6. 图片

VPU 支持 JPEG/MJPEG 解码，最高 7680x4320@30。

```
timeout 30 gst-launch-1.0 -q filesrc location=photo.jpg \
	! jpegparse ! v4l2jpegdec ! video/x-raw,format=NV12 ! fakesink
```

务必加 timeout：实测十次里挂过一次。

```
gst-launch-1.0 videotestsrc num-buffers=30 ! \
	video/x-raw,width=1920,height=1080,format=NV12 ! \
	v4l2jpegenc ! filesink location=out.mjpeg
```

## 7. 多路并发

H.264、HEVC、AV1、VP9 最多可同时 16 路 1080p60 或 60 路 720p25。多进程方式：

```
for i in $(seq 1 10); do
	gst-launch-1.0 -q filesrc location=clip.mp4 ! qtdemux ! h264parse \
		! v4l2h264dec ! fakesink &
done
wait
```

同时观察 CPU 占用：硬解时占用很低。若出现丢帧，减少路数或降分辨率。

## 8. 监控 VPU

```
sudo ls /sys/kernel/debug/amvx/log/group
echo 3 | sudo tee /sys/kernel/debug/amvx/log/group/error/severity
sudo cat /sys/kernel/debug/amvx/log/drain/dmesg
```

日志等级：0 panic、1 error、2 warning、3 info、4 debug、5 verbose。

`/sys/kernel/debug/amvx/log/group/perf/` 下还有 `utilization`、
`realtime_fps`、`average_fps`。本机上写入 `enable` 后计数器仍返回
`VPU Performance Monitor is OFF`，因此实际测量请用第 4 节的外部方法。

## 9. 常见问题

| 现象 | 原因 | 处理 |
| --- | --- | --- |
| `no element "h264parse"` | 缺解析器 | 安装 `gstreamer1.0-plugins-bad` |
| `vaInitialize failed` | 缺 CIX VA-API 驱动 | 用 GStreamer V4L2 元件 |
| /dev/video0 权限不足 | 用户不在 `video` 组 | `usermod -aG video,render` |
| `Could not initialize canvas` | 无显示会话 | 设置 `WAYLAND_DISPLAY` 与 `XDG_RUNTIME_DIR` |
| JPEG 流程卡住 | `v4l2jpegdec` 已知问题 | 用 `timeout` 包裹 |
| WebM 里的 VP9 链接失败 | 解复用与解析器不匹配 | 改用 ffmpeg `vp9_v4l2m2m` |
| `no element "vp8parse"` | 本镜像缺该解析器 | 改用 ffmpeg `vp8_v4l2m2m` |
| 编码器拒绝输入 | 像素格式不对 | 输入 NV12 |

## 10. 参考

| 资料 | 内容 |
| --- | --- |
| [media.md](media.md) | 实测数据与能力表 |
| [../media/stack/v4l2.txt](../media/stack/v4l2.txt) | 本机设备与格式清单 |
| [../media/tools/run-media-bench.sh](../media/tools/run-media-bench.sh) | 测量脚本 |
| CIX-P1 多媒体开发指导手册 | GStreamer、Codec2、编解码矩阵 |
| CIX-P1-VPU 开发指导手册 | 驱动接口与多路性能 |
| CIX-P1-VAAPI 开发指导手册 | VA-API 软件栈 |
| CIX-P1-Linux GPU 开发使用手册 | GPU 栈、Zink、AFBC |

CIX 官方文档为厂商资料，未随本仓库分发。
