# Media

Video decode, image decode and encode data for the Lenovo LACM-MN101.

The report is in [../docs/media.md](../docs/media.md).

## Layout

| Path | Content |
| --- | --- |
| `stack/` | Driver, V4L2, GStreamer, ffmpeg, VA-API and OpenCL description |
| `decode/` | Decode and encode logs |
| `results/` | Parsed CSV and JSON |
| `charts/` | SVG charts |
| `tools/run-media-bench.sh` | The suite that produced the logs |
| `tools/make-media.py` | Parses the logs into `results/` and `charts/` |

## Run

On the target, as a user with passwordless sudo:

```
scp tools/run-media-bench.sh user@host:/tmp/
ssh user@host 'bash /tmp/run-media-bench.sh'
scp user@host:/tmp/cix-media.tgz .
```

Then, in the repository:

```
python3 media/tools/make-media.py
```

## Test clips

The script makes the clips on the target, with the hardware encoder where
it works. It also downloads one small 1080p H.264 sample for a real world
check. The clips are large, so they are not stored in this repository.
