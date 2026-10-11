# Benchmarks

Performance run on one Lenovo LACM-MN101, CIX Sky1 (CD8180), 8 GB LPDDR5.

The report is in [../docs/performance.md](../docs/performance.md).

## Layout

| Path | Content |
| --- | --- |
| `raw/` | Untouched command output |
| `results/` | Parsed CSV and JSON |
| `charts/` | SVG charts |
| `tools/run-benchmarks.sh` | The suite that produced `raw/` |
| `tools/make-results.py` | Parses `raw/` into `results/` and `charts/` |

## Run

On the target, as a user with passwordless sudo:

```
scp tools/run-benchmarks.sh user@host:/tmp/
ssh user@host 'bash /tmp/run-benchmarks.sh'
scp user@host:/tmp/cix-bench.tgz .
scp user@host:/tmp/cix-bench-extra.tgz .
```

Then, in the repository:

```
python3 benchmarks/tools/make-results.py
```

## Tools

| Tool | Use |
| --- | --- |
| sysbench | CPU and memory |
| 7-Zip | CPU, compression and decompression |
| mbw | Memory copy bandwidth |
| fio | NVMe throughput and latency |
| stress-ng | Load for the thermal run |
| glmark2 | OpenGL ES 2.0 |
| vulkaninfo | GPU identification |

## Notes

1. The run takes about 9 minutes on this board.
2. The CPU governor stays at `schedutil`. Boost is disabled in firmware.
3. The disk test writes `/data/cix-bench-fio.bin`, up to 2 GB, and removes
   it at the end. Check free space before a run.
4. The X11 GPU test fails without a session authorisation. The Wayland test
   works. It needs a running Wayland session for the same user.
