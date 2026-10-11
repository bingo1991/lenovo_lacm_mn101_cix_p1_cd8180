# Lenovo LACM-MN101 hardware notes and device tree

Hardware documentation for the Lenovo "AI Center MINI" LACM-MN101.
The machine runs on a CIX Sky1 (CD8180) SoC.

This repository holds:

* the ACPI tables of the firmware, raw and decompiled;
* a hardware inventory from the running Linux system;
* a device tree for the board, built from ACPI;
* the tools that made the collection.

The machine boots with UEFI and ACPI. The device tree is a reconstruction.
It is not used by the factory firmware.

## Hardware summary

| Item | Value |
| --- | --- |
| System | LENOVO LACM-MN101, "AI Center MINI" |
| SoC | CIX Sky1 / P1 CD8180, ARMv9 |
| CPU | 12 cores: 4x Cortex-A520 to 1.8 GHz, 8x Cortex-A720 to 2.6 GHz |
| GPU | Mali-G720 Immortalis, 5x linlon DP display pipelines |
| RAM | 8 GB LPDDR5-6000, 4x 2 GB on board, 32 bit |
| Storage | AirDisk 256 GB NVMe, MAXIO MAP1202 controller |
| Network | RTL8125 2.5GbE, RTL8852BE WiFi 6, Bluetooth 5.2 |
| Firmware | LENOVO BIOS-V1.03, 2026-06-12, 8 MB, UEFI, SMBIOS 3.6 |
| OS in the dump | Ubuntu 26.04, kernel 7.0.0-38-cix |

The full table is in [docs/hardware.md](docs/hardware.md).

## Layout

| Path | Content |
| --- | --- |
| `acpi/` | ACPI tables. Raw, decompiled, and a text dump. |
| `benchmarks/` | Performance run: raw logs, CSV, JSON and charts. |
| `hardware/` | Command output from the running system. |
| `dts/` | Device tree source, bindings, and `make` support. |
| `docs/` | Hardware, ACPI and device tree documents. |
| `tools/` | Collection and redaction scripts. |

## Quick start

Build the device tree:

```
cd dts
make
```

The build needs `cpp` and `dtc`. It needs no kernel tree.

Read the node sources in [docs/acpi-to-dt-mapping.md](docs/acpi-to-dt-mapping.md).

## Performance

The machine reached 2,790 events/s on one thread and 22,618 events/s on
twelve threads in `sysbench cpu`. The NVMe reached 1,932 MiB/s sequential
read and 273,257 IOPS random write. Peak SoC temperature under full load
was 58 degC, with no throttling.

Full report: [docs/performance.md](docs/performance.md). The charts are
in [benchmarks/charts](benchmarks/charts), the raw logs in
[benchmarks/raw](benchmarks/raw).

## How the data was collected

1. `tools/collect.sh` gathers the hardware inventory over SSH.
2. `tools/collect-acpi.sh` copies the ACPI tables, decompiles them with
   `iasl`, and backs up the EFI variables.
3. `tools/sanitize.sh` replaces device identifiers in the text output.

See [hardware/README.md](hardware/README.md) and
[acpi/README.md](acpi/README.md).

## Privacy

The published files contain no serial number, no MAC address, no UUID, no
global IPv6 address and no user name. `tools/sanitize.sh` made the
replacements. The EFI variable store is not published.

## License

MIT. See [LICENSE](LICENSE). Read [NOTICE.md](NOTICE.md) for the firmware
and device tree content.

## Status

The device tree compiles without warnings. It is not tested on hardware.
The ACPI tables and the inventory are from one machine.

## Disclaimer

This project is unofficial. It is not affiliated with Lenovo or CIX
Technology. All trademarks belong to their owners. Use at your own risk.
