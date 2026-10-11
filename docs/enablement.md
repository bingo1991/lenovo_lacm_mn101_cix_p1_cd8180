# Enablement: what can be turned on, what must stay off

Status of the vendor packages for the Lenovo LACM-MN101 (CIX Sky1 /
CD8180), Ubuntu 26.04, kernel 7.0.0-38-cix.

**两只手别碰的东西 Warning: never start the audio DSP, and keep the NPU
blacklisted. Both reset this machine.**

## 1. Already enabled out of the box

| Block | State | Notes |
| --- | --- | --- |
| GPU | working | `mali_kbase` DKMS, Vulkan 1.4, OpenCL 3.0, 10 cores |
| VPU | working | `amvx`, /dev/video0 to /dev/video3, all codecs |
| Display | working | five linlon DP pipelines |
| WiFi | working | RTL8852BE, 192.168.3.224 |
| Ethernet | working | RTL8125, port not connected |
| NVMe | working | AirDisk 256 GB |
| Sensors | working | five thermal zones, fan control by firmware |
| Audio | absent | the HDA controller finds no codec on this SKU |
| NPU | blacklisted | do not change |
| DSP | offline | do not start, see section 5 |

## 2. Vendor package sources

| Source | Content |
| --- | --- |
| PPA `cixee-team/cixee` | CIX kernels, `cix-gpu-dkms`, `cix-vpu-firmware` |
| PPA `ubuntu-concept/cix` | CIX kernels for Ubuntu |
| GitHub `cixtech/cix_p1_ubuntu_adaption_debs` | Vendor debs: VPU test tools, firmware, GStreamer, ffmpeg, NPU, WiFi |
| GitHub `cixtech/cix_vaapi` | VA-API driver source |
| GitHub `cixtech/cix_media_engine` | `libcme` source |

Both PPAs are already configured on the machine. The GitHub content is not.

Note: the vendor installer `cix_install.sh` supports jammy, noble and plucky.
It refuses resolute (26.04). Install single debs by hand instead.

## 3. Installed and verified

### VPU test tools

```
dpkg -i cix-vpu-test_1.0.0_arm64.deb
/usr/share/cix/bin/mvx_info
```

Tools: `mvx_decoder`, `mvx_encoder`, `mvx_info`, `mvx_logd`.

Measured with the official tools, 1080p60 clip of 600 frames:

| Tool | Command result | Wall | CPU |
| --- | --- | --- | --- |
| `mvx_decoder` H.264 to NV12 | 600 frames, 1.86 GB output | 1.26 s | 97 percent of one core |
| `mvx_decoder` HEVC to NV12 | 600 frames | 0.55 s | 35 percent of one core |
| `mvx_encoder` H.264, 352x288, 300 frames | 2.1 MB stream | 1.10 s | 62 percent of one core |

The tools write raw output. Check free space first: 600 frames of 1080p
NV12 are 1.86 GB.

## 4. Downloadable but not usable here

| Package | Problem |
| --- | --- |
| `cix-gstreamer_1.26.2_arm64.deb` | Built for GStreamer 1.26. This image has 1.28. The plugin fails to load with `gst_video_format_to_string` assertions. Do not mix. |
| `cix-alsa-conf_1.0.0_arm64.deb` | UCM profiles for HDMI and the codec. The HDA controller reports no codec, so it adds nothing. |
| `cix-env_1.0.0_arm64.deb` | Useful GLES environment variables, but the package also installs a wide `modprobe` blacklist that covers `fuse`, `overlay` and `btrfs`. That can break snap and Docker. Take only the environment file if you want it. |
| `cix-firmware_1.0.0_arm64.deb` | WiFi, Bluetooth and SFH blobs. WiFi and Bluetooth already work. The audio DSP blob is not in this package. |
| `ffmpeg_7.1.1-...deb`, `libavcodec61` | Built for Ubuntu 25.04. This image has newer ffmpeg libraries. The system ffmpeg already has the `v4l2m2m` wrappers. |

## 5. Blocked

| Component | Reason |
| --- | --- |
| VA-API driver | The source builds against `libcme`, and `libcme` links `libdrm_cix`. `libdrm_cix` is a BSP library and is not published. Without it the VA-API driver cannot be built. V4L2 M2M already gives the same hardware decode. |
| Super resolution `cixsr` | Not part of the public packages. |
| NPU | Driver and runtime are public, but the module crashes this machine. Keep the blacklist. |
| Audio | No codec on this SKU. No driver work can add one. |

## 6. Hard warning: the audio DSP resets the machine

The kernel has a remote processor for the audio DSP:

```
/sys/class/remoteproc/remoteproc0 -> name: cix-dsp-rproc, state: offline
```

Loading the vendor firmware and starting it:

```
cp dsp_fw.bin /lib/firmware/
echo start > /sys/class/remoteproc/remoteproc0/state
```

makes the machine reset. Evidence from the run on 2026-10-11:

1. The journal of that boot ends with
   `kernel: remoteproc remoteproc0: powering up cix-dsp-rproc`.
   There is no line after it.
2. The SSH connection dies at once.
3. The machine reboots. The status LED shows a red blink pattern.
4. Only a power cycle brings it back. After the boot the DSP is `offline`
   again, and nothing else is broken.

The firmware file is not the cause by itself. It was removed again. The
state is not persistent, so a normal boot never starts the DSP.

Do not repeat this test. The 45 TOPS NPU and the DSP are not worth a
machine that resets.

## 7. Safe enablement checklist

| Step | Command | Gain |
| --- | --- | --- |
| VPU tools | `dpkg -i cix-vpu-test_1.0.0_arm64.deb` | Official decode and encode tools, VPU logs |
| Video decode | use `v4l2h264dec`, `h264_v4l2m2m` and friends | Hardware decode, already working |
| GPU checks | `clinfo`, `vulkaninfo` | OpenCL 3.0 and Vulkan 1.4 confirmed |
| AFBC for Xwayland | `echo ENABLE_XWAYLAND_AFBC=1 > /etc/environment.d/cix_env.conf` | Less GPU bandwidth in X11 apps |
| GLES environment | add `GDK_GL=gles`, `QT_OPENGL=es2`, `GST_GL_API=gles2` to `/etc/environment.d/` | Use the Mali GLES path instead of Zink |
| Media checks | `v4l2-ctl --list-devices`, `vainfo`, `gst-inspect-1.0` | Fast state check |

Apply environment changes one at a time and re-login. Keep the changes in
`/etc/environment.d/` so a package upgrade does not remove them.

## 8. If the machine stops answering

1. The DSP and the NPU do not survive a reset. Power cycle the machine.
2. Nothing in this repository is required for a normal boot.
3. Check the status LED. A steady pattern after the boot means the firmware
   finished. A red blink pattern during the boot is not normal, but the
   machine recovered on the next power cycle in our test.

中文摘要：

1. 已经打开的：GPU（kbase + OpenCL 3.0 + Vulkan 1.4）、VPU（8 种解码 + 5 种编码）、
   显示、网络、存储、传感器。
2. 可以直接装的厂商包：CIX 官方 VPU 测试工具（已装并实测）。
3. 装了也没用的：CIX GStreamer 1.26 插件（本机 GStreamer 1.28，ABI 不匹配）、
   ALSA UCM（本 SKU 无 codec）、cix-env（自带大范围 modprobe 黑名单，会破坏 snap/Docker）。
4. 拿不到的：VA-API 驱动依赖未公开的 BSP 库 libdrm_cix；超分元件 cixsr 未发布。
5. **绝对不要启动音频 DSP**：`echo start > /sys/class/remoteproc/remoteproc0/state`
   会让整机重启并亮故障灯，只能强制断电恢复。NPU 继续保持 blacklist。
