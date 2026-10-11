# ACPI to device tree mapping

Board: Lenovo LACM-MN101 "AI Center MINI".

## Sources

| Source | Content |
| --- | --- |
| DSDT | SoC blocks. OEM ID CIXTEK, OEM table ID SKY1EDK2. |
| SSDT1 | Board devices: sound, RTC, cameras, Type-C, GPIO keys and LEDs, regulators. |
| SSDT2 | CPU containers only. |
| /proc/iomem | Memory ranges. |
| inxi, lshw, lspci, lsusb | Live hardware. |
| i2cdetect | Devices on each I2C bus. |
| ACPI DBG2 | Debug UART. |

Many ACPI devices use `_HID` `PRP0001` with a `_DSD` `compatible` string.
Those devices are already described in device tree style. The board file
copies that description almost one to one.

## Node mapping

| Device tree node | ACPI source | Live evidence |
| --- | --- | --- |
| `model`, `compatible` | SMBIOS type 1 `LACM-MN101` | inxi, lshw |
| `memory@100000000` | none | /proc/iomem |
| `reserved-memory/ramoops` | DSDT `RAOP`, compatible `ramoops` | none |
| `reserved-memory/linux,cma` | none | CMA of the vendor kernel |
| `leds/led-status` | SSDT1 `LED1` + `LDU1`, trigger `heartbeat` | none |
| `keys/key-power` | SSDT1 `PKEY` + `LDU1`, code 0x74 = KEY_POWER | none |
| `regulator-ssd1` | SSDT1 `PVC1`, name `ssd1_power` | none |
| `regulator-ssd2` | SSDT1 `PVC0`, name `ssd2_power` | none |
| `regulator-wifi` | SSDT1 `PVC4`, name `wifi_vbat` | none |
| `pcie_x1_0_rc` | DSDT `PCI4`, MMIO 0x30000000 | 01:00.0 RTL8852BE WiFi |
| `pcie_x2_rc` | DSDT `PCI2`, MMIO 0x40000000 | 61:00.0 RTL8125 Ethernet |
| `pcie_x8_rc` | DSDT `PCI0`, MMIO 0x60000000 | c1:00.0 NVMe SSD |
| `i2c0` | DSDT `I2C0` `CIXH200B`, 0x04010000 | i2c-0 |
| `i2c1` | DSDT `I2C1`, 0x04020000 | i2c-1 |
| `i2c2` | DSDT `I2C2`, 0x04030000 | no bus, disabled |
| `i2c3` | DSDT `I2C3`, 0x04040000 | i2c-2 |
| `i2c7` | DSDT `I2C7`, 0x04080000 | i2c-3 |
| `codec@1a` | SSDT1 `RTL5` `RTL5682` on `I2C2` | no ALSA card, disabled |
| `rtc@32` | SSDT1 `RTC0` `RX008900` on `I2C3` | i2c-2 address 0x32 busy |
| `typec@30`, `typec@31` | SSDT1 `PD00`, `PD01` `CIXH200D` on `I2C7` | i2c-3 addresses 0x30 and 0x31 busy |
| `camera@34`, `vcm@40` | SSDT1 `IIS0`, `MTR0` on `I2C0` | no device answers |
| `camera@36`, `camera@38` | SSDT1 `IIS1`, `IIS2` on `I2C1` | no device answers |
| `spi0` | DSDT `SPI0` `CIXH2001`, SSDT1 `TP3`, `TP4` | no spidev, disabled |
| `uart2` | ACPI DBG2 | debug port 0x040d0000, subtype ARM SBSA UART |
| `gpio0` .. `gpio6` | DSDT `GPI0` `CIXH1002`, `GPI1`-`GPI6` `CIXH1003` | none |
| `iomuxc` | SSDT1 `MUX0` `CIXHA016`, 0x04170000 | none |
| `iomuxc_s5` | SSDT1 `MUX1` `CIXHA017`, 0x16007000 | none |

## Resource details

GPIO controllers:

| Node | ACPI HID | Address | GIC SPI | Pins |
| --- | --- | --- | --- | --- |
| `gpio0` | CIXH1002 | 0x04120000 | 304 | 32 |
| `gpio1` | CIXH1003 | 0x04130000 | 305 | 32 |
| `gpio2` | CIXH1003 | 0x04140000 | 306 | 32 |
| `gpio3` | CIXH1003 | 0x04150000 | 307 | 32 |
| `gpio4` | CIXH1003 | 0x16004000 | 372 | 32 |
| `gpio5` | CIXH1003 | 0x16005000 | 373 | 32 |
| `gpio6` | CIXH1003 | 0x16006000 | 374 | 32 |

Interrupt consumers:

| Device | Controller | Pin | Trigger |
| --- | --- | --- | --- |
| RTL5682 codec | GPI3 | 10 | level low |
| RX008900 RTC | GPI4 | 10 | level low |
| RTS5453H Type-C | GPI4 | 7 | level low |
| LED status | GPI0 | 30 | output |
| Power key | GPI6 | 1 | input |
| ssd2 power | GPI4 | 8 | output |
| ssd1 power | GPI4 | 11 | output |
| wifi vbat | GPI4 | 12 | output |

The pin number in each row is the ACPI pin index of that controller. The
global pin number of the pinctrl driver is not yet confirmed.

## PCIe root ports

The DSDT declares five root ports, `PCI0` to `PCI4`. The memory window of
each port matches exactly one node of `sky1.dtsi`:

| ACPI | MMIO window | Device tree node | Bus range | Device found |
| --- | --- | --- | --- | --- |
| PCI0 | 0x60000000-0x7fffffff | `pcie_x8_rc` | c0-ff | NVMe |
| PCI1 | 0x50000000-0x5fffffff | `pcie_x4_rc` | 90-bf | none |
| PCI2 | 0x40000000-0x4fffffff | `pcie_x2_rc` | 60-8f | Ethernet |
| PCI3 | 0x38000000-0x3fffffff | `pcie_x1_1_rc` | 30-5f | none |
| PCI4 | 0x30000000-0x37ffffff | `pcie_x1_0_rc` | 00-2f | WiFi |

`pcie_x4_rc` and `pcie_x1_1_rc` stay disabled. `lspci` lists no device on
bus 0x30-0x5f or 0x90-0xbf.

## Not represented

These blocks exist in the DSDT but have no upstream binding. They stay out
of the board file.

| ACPI device | HID | Address | Note |
| --- | --- | --- | --- |
| `VPU0` | CIXH3010 | 0x14230000 | video decoder |
| `DPU0`-`DPU4` | CIXH5010 | 0x14010000 | display pipeline |
| `DP00`-`DP04` | CIXH502F | 0x14210000 | 5 DP outputs |
| `EDP0` | CIXH5040 | - | eDP output |
| `HDA` | CIXH6020 | 0x070c0000 | audio controller |
| `DSP` | CIXH6000 | 0x07000000 | HiFi5 DSP |
| `SUB0`-`SUB5` | CIXH2030 | 0x09000310 | USB3 host |
| `CUB0`-`CUB5` | CIXH2031 | 0x09010000 | USB3 controller |
| `DMA0`, `DMA1` | CIXHA014, CIXH1006 | 0x04190000, 0x07010000 | DMA350 |
| `XSPI` | CIXH2002 | 0x04180000 | boot flash |
| `PWM0`-`PWM5` | CIXH2011 | - | fans and backlight |
| `PDC0` | CIXHA019 | 0x16000000 | power domain controller |
| `HWMN` | CIXHA024 | - | hardware monitor |
| `EC0` | CIXHA015 | - | embedded controller |
| `MAC0`, `MAC1` | CIXH7020 | - | Ethernet MAC |

## Open items

1. GPI pin to global pinctrl pin mapping.
2. MUX0 and MUX1 `PinGroup` raw data. It holds vendor pinctrl values.
3. Camera and audio codec nodes. Both are absent on this SKU.
4. Panel timings. The panel is on a DP output. The EDID sits on the DP AUX
   bus, address 0x50.
