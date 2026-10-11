# Lenovo LACM-MN101 硬件资料与设备树

本仓库记录联想 AI Center MINI（型号 LACM-MN101）的硬件信息。整机使用
CIX Sky1（CD8180）芯片。

仓库内容：

* 固件 ACPI 表：原始表与反编译源；
* 运行系统的硬件采集输出；
* 依据 ACPI 重建的设备树；
* 采集与脱敏脚本。

该机使用 UEFI 与 ACPI 启动。设备树是重建结果，原厂固件不使用它。

## 硬件概要

| 项目 | 值 |
| --- | --- |
| 整机 | LENOVO LACM-MN101，AI Center MINI |
| SoC | CIX Sky1 / P1 CD8180，ARMv9 |
| CPU | 12 核：4×Cortex-A520 至 1.8 GHz，8×Cortex-A720 至 2.6 GHz |
| GPU | Mali-G720 Immortalis，5 路 linlon DP 显示 |
| 内存 | 8 GB LPDDR5-6000，板载 4×2 GB，32 位 |
| 存储 | AirDisk 256 GB NVMe，MAXIO MAP1202 |
| 网络 | RTL8125 2.5GbE，RTL8852BE WiFi 6，蓝牙 5.2 |
| 固件 | LENOVO BIOS-V1.03，2026-06-12，8 MB，UEFI，SMBIOS 3.6 |
| 采集时系统 | Ubuntu 26.04，内核 7.0.0-38-cix |

完整规格见 [docs/hardware.md](docs/hardware.md)。

## 目录

| 路径 | 内容 |
| --- | --- |
| `acpi/` | ACPI 原始表、反编译源、文本转储 |
| `benchmarks/` | 性能测试：原始日志、CSV/JSON 数据、图表 |
| `hardware/` | 运行系统的命令输出 |
| `dts/` | 设备树源、binding 头文件、Makefile |
| `docs/` | 硬件、ACPI 与设备树文档 |
| `tools/` | 采集与脱敏脚本 |

## 快速开始

```
cd dts
make
```

需要 `cpp` 与 `dtc`，不需要内核源码。节点来源见
[docs/acpi-to-dt-mapping.md](docs/acpi-to-dt-mapping.md)。

## 性能

sysbench cpu 单线程 2,790 events/s，12 线程 22,618 events/s。NVMe 顺序读
1,932 MiB/s，4K 随机写 273,257 IOPS。整机满载时 SoC 峰值 58 °C，无降频。

报告见 [docs/performance.md](docs/performance.md)，图表在
[benchmarks/charts](benchmarks/charts)，原始日志在 [benchmarks/raw](benchmarks/raw)。

## 隐私

公开文件中不含序列号、MAC 地址、UUID、公网 IPv6 地址与用户名。
替换由 `tools/sanitize.sh` 完成。EFI 变量未公开。

## 许可

MIT，见 [LICENSE](LICENSE)。固件表与设备树的来源见 [NOTICE.md](NOTICE.md)。

## 声明

本项目为独立工作，与联想、CIX 无关联。商标归各自所有者。使用风险自担。
