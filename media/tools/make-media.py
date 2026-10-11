#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Turn the media logs into CSV, JSON and SVG charts.

Run from the repository root:

    python3 media/tools/make-media.py

The script needs no third party module.
"""

import csv
import glob
import json
import os
import re

HERE = os.path.dirname(os.path.abspath(__file__))
MEDIA = os.path.dirname(HERE)
DECODE = os.path.join(MEDIA, "decode")
STACK = os.path.join(MEDIA, "stack")
RES = os.path.join(MEDIA, "results")
CHART = os.path.join(MEDIA, "charts")

COLORS = ["#1f77b4", "#d62728", "#2ca02c", "#ff7f0e", "#9467bd"]

# name, label, log prefix, frame count
FFMPEG_TESTS = [
    ("h264-1080p-hw", "H.264 1080p, hardware", "hw-h264-1080p", 600),
    ("h264-1080p-sw", "H.264 1080p, software", "sw-h264-1080p", 600),
    ("hevc-1080p-hw", "HEVC 1080p, hardware", "hw-hevc-1080p", 600),
    ("hevc-1080p-sw", "HEVC 1080p, software", "sw-hevc-1080p", 600),
    ("h264-4k-hw", "H.264 2160p, hardware", "hw-h264-4k", 300),
    ("vp9-360p-hw", "VP9 360p, hardware", "hw-vp9-360p", 60),
    ("h264-real-hw", "H.264 1080p real clip, hardware", "hw-h264-real", 300),
    ("h264-real-sw", "H.264 1080p real clip, software", "sw-h264-real", 300),
]


def read(path):
    with open(path, errors="replace") as fh:
        return fh.read()


def write_csv(name, header, rows):
    with open(os.path.join(RES, name), "w", newline="") as fh:
        writer = csv.writer(fh)
        writer.writerow(header)
        writer.writerows(rows)


def median(values):
    values = sorted(values)
    return values[len(values) // 2] if values else 0.0


def parse_ffmpeg(prefix):
    """Return (frames, wall seconds, cpu seconds) as the median of the runs."""
    walls, cpus = [], []
    for path in glob.glob(os.path.join(DECODE, "ffmpeg", f"{prefix}.run*.txt")):
        match = re.search(r"bench: utime=([\d.]+)s stime=([\d.]+)s rtime=([\d.]+)s", read(path))
        if match:
            cpus.append(float(match.group(1)) + float(match.group(2)))
            walls.append(float(match.group(3)))
    return median(walls), median(cpus)


def parse_time(path):
    """Return (wall seconds, cpu percent) of a /usr/bin/time log."""
    text = read(path)
    wall = re.search(r"wall=([\d.]+)", text)
    cpu = re.search(r"cpu=([\d.]+)%", text)
    if not wall:
        return None
    return float(wall.group(1)), float(cpu.group(1)) if cpu else 0.0


def svg_header(width, height, title):
    return [
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" '
        f'viewBox="0 0 {width} {height}" font-family="DejaVu Sans, Arial, sans-serif">',
        f'<rect width="{width}" height="{height}" fill="#ffffff"/>',
        f'<text x="24" y="34" font-size="20" font-weight="bold" fill="#222">{title}</text>',
    ]


def write_bars(name, title, items, unit, color="#1f77b4"):
    left, top, bar_h, gap = 300, 60, 30, 14
    width = 960
    height = top + len(items) * (bar_h + gap) + 50
    span = max(value for _, value in items) or 1
    scale = (width - left - 140) / span

    out = svg_header(width, height, title)
    for index, (label, value) in enumerate(items):
        y = top + index * (bar_h + gap)
        length = max(2, value * scale)
        out.append(f'<text x="{left - 12}" y="{y + bar_h * 0.7:.0f}" font-size="15" '
                   f'text-anchor="end" fill="#333">{label}</text>')
        out.append(f'<rect x="{left}" y="{y}" width="{length:.1f}" height="{bar_h}" '
                   f'rx="3" fill="{color}"/>')
        out.append(f'<text x="{left + length + 8:.0f}" y="{y + bar_h * 0.7:.0f}" '
                   f'font-size="15" fill="#222">{value:,.0f} {unit}</text>')
    out.append("</svg>")
    with open(os.path.join(CHART, name), "w") as fh:
        fh.write("\n".join(out) + "\n")


def main():
    os.makedirs(RES, exist_ok=True)
    os.makedirs(CHART, exist_ok=True)
    summary = {"decode": [], "gstreamer": [], "image": [], "encode": []}

    rows = []
    for name, label, prefix, frames in FFMPEG_TESTS:
        wall, cpu = parse_ffmpeg(prefix)
        if not wall:
            continue
        entry = {"test": name, "label": label, "frames": frames,
                 "wall_s": round(wall, 3), "cpu_s": round(cpu, 3),
                 "fps": round(frames / wall, 1), "cores": round(cpu / wall, 2)}
        rows.append(entry)
        summary["decode"].append(entry)
    write_csv("decode.csv",
              ["test", "label", "frames", "wall_s", "cpu_s", "fps", "cores"],
              [[r["test"], r["label"], r["frames"], r["wall_s"], r["cpu_s"], r["fps"], r["cores"]]
               for r in rows])

    gst_rows = []
    for name in ("gst-v4l2h264dec", "gst-avdec-h264", "gst-v4l2h265dec"):
        result = parse_time(os.path.join(DECODE, "gst", f"{name}.time"))
        if not result:
            continue
        wall, cpu = result
        entry = {"test": name, "wall_s": wall, "cpu_percent": cpu}
        gst_rows.append(entry)
        summary["gstreamer"].append(entry)
    write_csv("gstreamer.csv", ["test", "wall_s", "cpu_percent"],
              [[r["test"], r["wall_s"], r["cpu_percent"]] for r in gst_rows])

    jpeg_text = read(os.path.join(DECODE, "jpeg.txt"))
    image_rows = []
    for label, marker in (("4K JPEG, hardware v4l2jpegdec", "hw v4l2jpegdec, single image"),
                          ("4K JPEG, software jpegdec", "sw jpegdec")):
        block = jpeg_text.split(f"== {marker}", 1)
        if len(block) < 2:
            continue
        result = parse_time_text(block[1][:200])
        if result:
            entry = {"test": marker, "label": label, "wall_s": result[0],
                     "cpu_percent": result[1], "images_per_second": round(1 / result[0], 1)}
            image_rows.append(entry)
            summary["image"].append(entry)
    write_csv("image.csv", ["test", "label", "wall_s", "cpu_percent", "images_per_second"],
              [[r["test"], r["label"], r["wall_s"], r["cpu_percent"], r["images_per_second"]]
               for r in image_rows])

    codec_text = read(os.path.join(DECODE, "codecs.txt"))
    encode_rows = []
    for label, marker in (("H.264 1080p, hardware encoder", "h264 hw encode 1080p x300"),
                          ("JPEG 1080p, hardware encoder", "jpeg hw encode 1080p x30")):
        block = codec_text.split(f"== {marker}", 1)
        if len(block) < 2:
            continue
        result = parse_time_text(block[1][:200])
        if result:
            entry = {"test": marker, "label": label, "wall_s": result[0], "cpu_percent": result[1]}
            encode_rows.append(entry)
            summary["encode"].append(entry)
    write_csv("encode.csv", ["test", "label", "wall_s", "cpu_percent"],
              [[r["test"], r["label"], r["wall_s"], r["cpu_percent"]] for r in encode_rows])

    summary["gpu"] = {"from_clinfo": grep_first(os.path.join(STACK, "clinfo.txt"),
                                                r"Device Version\s+(.+)$", "device version"),
                      "compute_units": grep_first(os.path.join(STACK, "clinfo.txt"),
                                                  r"Max compute units\s+(\d+)", "compute units")}
    summary["vaapi"] = "driver missing" if "va_openDriver() returns -1" \
        in read(os.path.join(STACK, "vainfo.txt")) else "present"

    with open(os.path.join(RES, "summary.json"), "w") as fh:
        json.dump(summary, fh, indent=2)
        fh.write("\n")

    write_bars("decode-fps.svg", "Video decode throughput",
               [(r["label"], r["fps"]) for r in rows], "fps")
    write_bars("decode-cpu.svg", "CPU used during video decode",
               [(r["label"], r["cores"]) for r in rows], "cores", "#d62728")
    if image_rows:
        write_bars("image-wall.svg", "4K JPEG decode, one image",
                   [(r["label"], r["wall_s"] * 1000) for r in image_rows], "ms", "#2ca02c")
    print("results written to", RES)
    print("charts written to", CHART)


def parse_time_text(text):
    wall = re.search(r"wall=([\d.]+)", text)
    cpu = re.search(r"cpu=([\d.]+)%", text)
    if not wall:
        return None
    return float(wall.group(1)), float(cpu.group(1)) if cpu else 0.0


def grep_first(path, pattern, default):
    match = re.search(pattern, read(path), re.M)
    return match.group(1).strip() if match else default


if __name__ == "__main__":
    main()
