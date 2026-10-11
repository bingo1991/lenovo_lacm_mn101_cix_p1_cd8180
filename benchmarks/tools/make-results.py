#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Turn the benchmark logs into CSV, JSON and SVG charts.

Run from the repository root:

    python3 benchmarks/tools/make-results.py

The script needs no third party module.
"""

import csv
import glob
import json
import os
import re

HERE = os.path.dirname(os.path.abspath(__file__))
BENCH = os.path.dirname(HERE)
RAW = os.path.join(BENCH, "raw")
RES = os.path.join(BENCH, "results")
CHART = os.path.join(BENCH, "charts")

COLORS = ["#1f77b4", "#d62728", "#2ca02c", "#ff7f0e", "#9467bd", "#8c564b"]


def read(path):
    with open(path, errors="replace") as fh:
        return fh.read()


def write_csv(name, header, rows):
    path = os.path.join(RES, name)
    with open(path, "w", newline="") as fh:
        writer = csv.writer(fh)
        writer.writerow(header)
        writer.writerows(rows)
    return path


# ---------------------------------------------------------------- parsers

def parse_sysbench(path):
    """Return events per second of a sysbench cpu run."""
    match = re.search(r"events per second:\s+([\d.]+)", read(path))
    return float(match.group(1)) if match else None


def parse_sysbench_threads(path):
    """Return (events per second, mean latency in ms, 95th percentile)."""
    text = read(path)
    events = re.search(r"total number of events:\s+(\d+)", text)
    total = re.search(r"total time:\s+([\d.]+)s", text)
    avg = re.search(r"avg:\s+([\d.]+)", text)
    p95 = re.search(r"95th percentile:\s+([\d.]+)", text)
    if not (events and total):
        return None, None, None
    return (float(events.group(1)) / float(total.group(1)),
            float(avg.group(1)) if avg else None,
            float(p95.group(1)) if p95 else None)


def parse_sysbench_memory(path):
    """Return (MiB, MiB per second) of a sysbench memory run."""
    match = re.search(r"([\d.]+) MiB transferred \(([\d.]+) MiB/sec\)", read(path))
    return (float(match.group(1)), float(match.group(2))) if match else (None, None)


def parse_7z(path):
    """Return the total rating of a 7-Zip benchmark, in MIPS."""
    match = re.search(r"^Tot:\s+([\d ]+)$", read(path), re.M)
    if not match:
        return None
    return int(match.group(1).split()[-1])


def parse_mbw(path):
    """Return {method: MiB per second} of one mbw run."""
    out = {}
    for line in read(path).splitlines():
        if not line.startswith("AVG"):
            continue
        cells = re.split(r"\t+", line.strip())
        if len(cells) < 5:
            continue
        out[cells[1].split(": ")[1]] = float(cells[-1].split()[-2])
    return out


def parse_fio(path):
    """Return the main numbers of a fio JSON run."""
    job = json.loads(read(path))["jobs"][0]
    main = job["read"] if job["read"]["io_bytes"] >= job["write"]["io_bytes"] else job["write"]
    return {
        "read_iops": round(job["read"]["iops"], 1),
        "write_iops": round(job["write"]["iops"], 1),
        "read_mib_s": round(job["read"]["bw"] / 1024, 1),
        "write_mib_s": round(job["write"]["bw"] / 1024, 1),
        "lat_mean_ms": round(main["clat_ns"]["mean"] / 1e6, 3),
        "lat_p99_ms": round(main["clat_ns"]["percentile"]["99.000000"] / 1e6, 3),
    }


def parse_glmark2(path):
    match = re.search(r"glmark2 Score:\s+(\d+)", read(path))
    return int(match.group(1)) if match else None


def parse_stress_ng(path):
    match = re.search(
        r"^stress-ng: metrc:.*?\bcpu\s+(\d+)\s+([\d.]+)\s+([\d.]+)\s+([\d.]+)\s+([\d.]+)\s+([\d.]+)",
        read(path), re.M)
    if not match:
        return {}
    return {"bogo_ops": int(match.group(1)),
            "real_time_s": float(match.group(2)),
            "bogo_ops_per_second": float(match.group(5))}


def parse_vulkan(path):
    out = {}
    for key in ("deviceName", "apiVersion", "driverInfo"):
        match = re.search(rf"{key}\s+=\s+(.+)", read(path))
        if match:
            out[key] = match.group(1).strip()
    return out


# ---------------------------------------------------------------- charts

def svg_header(width, height, title):
    return [
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" '
        f'viewBox="0 0 {width} {height}" font-family="DejaVu Sans, Arial, sans-serif">',
        f'<rect width="{width}" height="{height}" fill="#ffffff"/>',
        f'<text x="24" y="34" font-size="20" font-weight="bold" fill="#222">{title}</text>',
    ]


def write_bars(name, title, items, unit, color="#1f77b4"):
    """items is a list of (label, value). Draw horizontal bars."""
    left, top, bar_h, gap = 250, 60, 30, 14
    width = 900
    height = top + len(items) * (bar_h + gap) + 50
    span = max(value for _, value in items) or 1
    scale = (width - left - 120) / span

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
    out.append(f'<text x="24" y="{height - 16}" font-size="13" fill="#666">'
               f'Larger is better. Unit: {unit}.</text>')
    out.append("</svg>")
    path = os.path.join(CHART, name)
    with open(path, "w") as fh:
        fh.write("\n".join(out) + "\n")
    return path


def write_lines(name, title, series, xlabel, ylabel):
    """series is a list of (label, [values]). All series share one x axis."""
    width, height = 900, 480
    left, top, right, bottom = 80, 60, 30, 70
    plot_w = width - left - right
    plot_h = height - top - bottom
    count = len(series[0][1])
    high = max(max(values) for _, values in series) * 1.1

    def px(index):
        return left + plot_w * index / max(1, count - 1)

    def py(value):
        return top + plot_h - plot_h * value / high

    out = svg_header(width, height, title)
    for step in range(5):
        value = high * step / 4
        y = py(value)
        out.append(f'<line x1="{left}" y1="{y:.0f}" x2="{width - right}" y2="{y:.0f}" '
                   f'stroke="#e6e6e6"/>')
        out.append(f'<text x="{left - 10}" y="{y + 5:.0f}" font-size="13" '
                   f'text-anchor="end" fill="#666">{value:.0f}</text>')
    out.append(f'<line x1="{left}" y1="{top}" x2="{left}" y2="{top + plot_h}" stroke="#999"/>')
    out.append(f'<line x1="{left}" y1="{top + plot_h}" x2="{width - right}" '
               f'y2="{top + plot_h}" stroke="#999"/>')
    for index in range(0, count, max(1, count // 12)):
        out.append(f'<text x="{px(index):.0f}" y="{top + plot_h + 22}" font-size="13" '
                   f'text-anchor="middle" fill="#666">{index}</text>')
    for index, (label, values) in enumerate(series):
        points = " ".join(f"{px(i):.1f},{py(v):.1f}" for i, v in enumerate(values))
        color = COLORS[index % len(COLORS)]
        out.append(f'<polyline points="{points}" fill="none" stroke="{color}" stroke-width="2.5"/>')
        out.append(f'<rect x="{left + 10 + index * 150}" y="{height - 30}" width="14" '
                   f'height="10" fill="{color}"/>')
        out.append(f'<text x="{left + 30 + index * 150}" y="{height - 21}" font-size="14" '
                   f'fill="#333">{label}</text>')
    out.append(f'<text x="{width / 2:.0f}" y="{height - 6}" font-size="13" fill="#666" '
               f'text-anchor="middle">{xlabel}</text>')
    out.append(f'<text x="16" y="{top + plot_h / 2:.0f}" font-size="13" fill="#666" '
               f'transform="rotate(-90 16 {top + plot_h / 2:.0f})" text-anchor="middle">{ylabel}</text>')
    out.append("</svg>")
    path = os.path.join(CHART, name)
    with open(path, "w") as fh:
        fh.write("\n".join(out) + "\n")
    return path


# ---------------------------------------------------------------- main

def main():
    os.makedirs(RES, exist_ok=True)
    os.makedirs(CHART, exist_ok=True)
    summary = {}

    cpu_rows = []
    for threads in (1, 4, 8, 12):
        value = parse_sysbench(os.path.join(RAW, "cpu", f"sysbench-cpu-{threads}.txt"))
        if value:
            cpu_rows.append({"test": "sysbench cpu", "threads": threads,
                             "label": f"{threads} thread" + ("s" if threads > 1 else ""),
                             "events_per_second": round(value, 1),
                             "note": "any core"})
    for label, filename, threads, note in (
        ("a520", "sysbench-cpu-a520-cluster.txt", 4, "4 Cortex-A520, pinned"),
        ("a720", "sysbench-cpu-a720-cluster.txt", 8, "8 Cortex-A720, pinned"),
    ):
        value = parse_sysbench(os.path.join(RAW, "cpu", filename))
        if value:
            cpu_rows.append({"test": "sysbench cpu", "threads": threads,
                             "label": f"{threads}x {label.upper()}",
                             "events_per_second": round(value, 1), "note": note})
    threads_rate, threads_avg, threads_p95 = parse_sysbench_threads(
        os.path.join(RAW, "cpu", "sysbench-threads-12.txt"))
    seven_single = parse_7z(os.path.join(RAW, "cpu", "7z-single.txt"))
    seven_multi = parse_7z(os.path.join(RAW, "cpu", "7z-multi.txt"))
    summary["cpu"] = {
        "sysbench_cpu": cpu_rows,
        "sysbench_threads_12": {
            "events_per_second": round(threads_rate, 1) if threads_rate else None,
            "latency_avg_ms": threads_avg,
            "latency_p95_ms": threads_p95,
        },
        "seven_zip_single_mips": seven_single,
        "seven_zip_multi_mips": seven_multi,
    }
    write_csv("cpu.csv", ["test", "threads", "label", "events_per_second", "note"],
              [[row["test"], row["threads"], row["label"], row["events_per_second"], row["note"]]
               for row in cpu_rows])

    memory_rows = []
    for threads, filename in ((1, "sysbench-memory-1.txt"), (12, "sysbench-memory-12.txt")):
        _, rate = parse_sysbench_memory(os.path.join(RAW, "memory", filename))
        if rate:
            memory_rows.append(("sysbench", f"{threads} thread", round(rate, 1)))
    _, rate = parse_sysbench_memory(
        os.path.join(RAW, "memory", "sysbench-memory-a520-cluster.txt"))
    if rate:
        memory_rows.append(("sysbench", "4 Cortex-A520", round(rate, 1)))
    runs = [parse_mbw(os.path.join(RAW, "memory", f"mbw-run{i}.txt")) for i in (1, 2, 3)]
    for method in ("MEMCPY", "DUMB", "MCBLOCK"):
        values = sorted(run[method] for run in runs if method in run)
        if values:
            memory_rows.append(("mbw", method, round(values[len(values) // 2], 1)))
    write_csv("memory.csv", ["benchmark", "method", "mib_per_second"],
              [list(row) for row in memory_rows])
    summary["memory"] = [{"benchmark": a, "method": b, "mib_per_second": c}
                         for a, b, c in memory_rows]

    disk_rows = []
    for path in sorted(glob.glob(os.path.join(RAW, "disk", "*.txt"))):
        row = parse_fio(path)
        row["test"] = os.path.basename(path)[:-4]
        disk_rows.append(row)
    write_csv("disk.csv",
              ["test", "read_iops", "write_iops", "read_mib_s", "write_mib_s",
               "lat_mean_ms", "lat_p99_ms"],
              [[row["test"], row["read_iops"], row["write_iops"], row["read_mib_s"],
                row["write_mib_s"], row["lat_mean_ms"], row["lat_p99_ms"]] for row in disk_rows])
    summary["disk"] = disk_rows

    thermal_path = os.path.join(RAW, "thermal", "thermal.csv")
    thermal = list(csv.DictReader(open(thermal_path)))
    with open(os.path.join(RES, "thermal.csv"), "w", newline="") as fh:
        fh.write(read(thermal_path))
    summary["thermal"] = {
        "peak_core_c": max(int(row["coretemp_max_c"]) for row in thermal),
        "peak_zone_c": max(max(int(row[f"z{i}"]) for i in range(5)) for row in thermal) / 1000,
        "nvme_c": max(int(row["nvme_c"]) for row in thermal),
        "stress_ng": parse_stress_ng(os.path.join(RAW, "thermal", "stress-ng.txt")),
    }

    summary["gpu"] = {
        "vulkan": parse_vulkan(os.path.join(RAW, "gpu", "vulkaninfo.txt")),
        "glmark2_wayland": parse_glmark2(os.path.join(RAW, "gpu", "glmark2-wayland.txt")),
        "glmark2_x11": "not available, session authorisation refused",
    }

    with open(os.path.join(RES, "summary.json"), "w") as fh:
        json.dump(summary, fh, indent=2)
        fh.write("\n")

    write_bars("cpu-scaling.svg", "CPU throughput, sysbench cpu",
               [(row["label"], row["events_per_second"]) for row in cpu_rows], "events/s")
    write_bars("memory-bandwidth.svg", "Memory bandwidth",
               [(f"{a} {b}", c) for a, b, c in memory_rows], "MiB/s", "#2ca02c")
    write_bars("disk-throughput.svg", "NVMe throughput, fio",
               [(row["test"], max(row["read_mib_s"], row["write_mib_s"])) for row in disk_rows],
               "MiB/s", "#ff7f0e")
    write_bars("disk-iops.svg", "NVMe operations, fio",
               [(row["test"], max(row["read_iops"], row["write_iops"])) for row in disk_rows],
               "IOPS", "#9467bd")
    write_lines("thermal-load.svg", "Temperature under 12 thread load",
                [("core", [int(row["coretemp_max_c"]) for row in thermal]),
                 ("z0", [int(row["z0"]) / 1000 for row in thermal]),
                 ("z1", [int(row["z1"]) / 1000 for row in thermal]),
                 ("z2", [int(row["z2"]) / 1000 for row in thermal]),
                 ("nvme", [int(row["nvme_c"]) for row in thermal])],
                "seconds", "degC")
    print("results written to", RES)
    print("charts written to", CHART)


if __name__ == "__main__":
    main()
