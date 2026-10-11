# Hardware

All values come from the running system. See `hardware/` for the raw output.

## System

| Item | Value |
| --- | --- |
| Model | LENOVO LACM-MN101, "AI Center MINI" |
| Chassis | Mini PC, single board |
| Firmware | LENOVO BIOS-V1.03, release date 2026-06-12 |
| Firmware ROM | 8 MB, UEFI, upgradable |
| SMBIOS | 3.6.0 |
| TPM | none. No SMBIOS type 43. |

## SoC

| Item | Value |
| --- | --- |
| Name | CIX P1 CD8180, also called Sky1 |
| Cores | 12. Four Cortex-A520, eight Cortex-A720. |
| Clocks | A520 to 1.8 GHz, A720 to 2.6 GHz |
| Cache | L1I and L1D 640 kB, L2 4 MB, L3 12 MB |
| ISA | ARMv9, SVE2, I8MM, BF16, MTE |
| NPU | ArmChina NPU block. The driver is blacklisted in the OS image. |

## Memory

| Item | Value |
| --- | --- |
| Type | LPDDR5-6000 |
| Size | 8 GB. Four on-board devices of 2 GB. |
| Width | 32 bit per device |
| MemTotal | 7.39 GiB. The firmware keeps about 2 GB of the map. |
| Maximum | 64 GB per SMBIOS |
| Error correction | none |

## Storage

| Item | Value |
| --- | --- |
| Disk | AirDisk 256 GB SSD |
| Controller | MAXIO MAP1202, PCI 1e4b:1202 |
| Link | 4 lanes, NVMe |
| Firmware | 29416 |
| Partitions | p1 1 GB vfat ESP, p2 8 GB vfat recovery, p3 131 GB ext4 root, p4 98.4 GB ext4 data |

The recovery partition holds an Ubuntu 26.04 installer image. It holds no
firmware.

## Network

| Item | Value |
| --- | --- |
| Ethernet | Realtek RTL8125 2.5GbE, PCI 10ec:8125, driver `r8169` |
| Ethernet firmware | rtl8125b-2_0.0.2 07/13/20 |
| WiFi | Realtek RTL8852BE, PCI 10ec:b852, driver `rtw89_8852be` |
| Bluetooth | IMC Networks 13d3:3570, driver `btusb`, Bluetooth 5.2, over USB |

The Ethernet port is not connected in the dump. The WiFi link carries the
network traffic.

## Graphics and display

| Item | Value |
| --- | --- |
| GPU | Mali-G720 Immortalis, driver `panthor` |
| Display | Five linlon DP pipelines, `linlondp` DRM |
| Framebuffer | `linlondpdrmfb` on /dev/fb0 |
| OpenGL | 4.6 over Zink, Mesa 25.1.5 |
| Vulkan | 1.4, Mali-G720 |
| Panel | IPS panel on a DP output |

## Buses

### PCIe

| Port | MMIO window | ID | Device |
| --- | --- | --- | --- |
| PCI0 | 0x60000000 | 1f6c:0001 | MAXIO MAP1202 NVMe at bus c1 |
| PCI1 | 0x50000000 | 1f6c:0001 | none |
| PCI2 | 0x40000000 | 1f6c:0001 | RTL8125 Ethernet at bus 61 |
| PCI3 | 0x38000000 | 1f6c:0001 | none |
| PCI4 | 0x30000000 | 1f6c:0001 | RTL8852BE WiFi at bus 01 |

### I2C

Four FCH controllers and five DP AUX channels.

| Bus | Address | Device |
| --- | --- | --- |
| i2c-0 | 0x04010000 | Camera connector. No device answers. |
| i2c-1 | 0x04020000 | Camera connector. No device answers. |
| i2c-2 | 0x04040000 | Epson RTC at 0x32 |
| i2c-3 | 0x04080000 | Two RTS5453H Type-C controllers at 0x30 and 0x31 |
| i2c-4 to i2c-8 | DP AUX | Display side channel. EDID EEPROM at 0x50 on i2c-8. |

The firmware also declares an I2C2 controller at 0x04030000 with a Realtek
RTL5682 audio codec. This SKU does not enable it. No ALSA card is present.

### Other

| Item | Value |
| --- | --- |
| UART | Four PL011 UART. UART2 at 0x040d0000 is the debug port. |
| SPI | Two Cadence SPI controllers. No device in use. |
| GPIO | Seven Cadence GPIO controllers, 32 pins each. |
| USB | Six USB controllers, 14 root hubs |
| Sensors | Five thermal zones, NVMe temperature, MDIO |

## Audio

The machine has no audio output in this Linux image. The chassis carries no
3.5 mm jack, so audio would go over HDMI or DP. The display side works, and
the audio side finds no endpoint.

| Item | Value |
| --- | --- |
| HD audio controller | `CIXH6020`, driver `cix-ipbloq-hda`, binds. Capabilities 0x4403. |
| Codec enumeration | `no codecs found` on every probe, with or without a display attached |
| HDMI codec driver | `snd-hda-codec-hdmi` loads. Still no codec. |
| ASoC machine driver | `CIXH6070`, `sky1-asoc-card`. Needs I2S device `CIXH6011:04`, which the firmware does not expose. |
| Declared codec | RT5682S, ACPI ID `RTL5682`, I2C2 address 0x1A. The firmware disables I2C2. No bus exists at 0x04030000. |
| Audio subsystem | `CIXH6060` with clock and reset children. Both drivers bind. |
| Audio DSP | `CIXH6000`, `cix-dsp-rproc`, offline. Starting it resets the machine. See [enablement.md](enablement.md). |
| ALSA cards | none |

Result: no audio over HDMI, over DP, or from an internal codec.

Working alternatives:

| Option | State |
| --- | --- |
| Bluetooth audio | Adapter up, Bluetooth 5.2. Pair a speaker or headset. |
| USB audio | `snd-usb-audio` is present. A USB sound card appears as a card. |

## Memory channels

ACPI declares four DDR controllers, `DCT0` to `DCT3`, one per channel.
Each controller reports its channel in `_DSD`. SMBIOS declares four memory
devices of 2 GB, LPDDR5-6000, 32 bit, soldered.

The bus is therefore 128 bit wide in four channels. 8 GB over four
channels is two packages of two dies each, or four single dies. The
firmware reports channels, not packages. Software alone cannot count the
packages. Open the case and look at the board to settle it.

## Board lineage

The board looks like a cut down Orange Pi 6 board. Both use the same SoC
and the same firmware OEM table ID, `SKY1EDK2`. The evidence found so far:

1. The firmware declares two on-die Ethernet MACs, `MAC0` at 0x09320000
   and `MAC1` at 0x09330000, each with a PHY child. Both are disabled with
   `_STA` zero. The product ships one RJ45 port, on a PCIe RTL8125.
2. The firmware declares five PCIe root ports. The machine uses three:
   NVMe, Ethernet and WiFi. `pcie_x1_1_rc` is unused. A second 2.5GbE port
   would fit there.
3. The firmware declares five DP outputs, six USB controllers and the
   camera connector. The user facing ports are fewer: HDMI, DP, one
   Ethernet, four USB-A and two USB-C.
4. Memory matches the same SoC design: 8 GB over four 32 bit LPDDR5
   channels at 6000 MT/s.

This list is consistent with a reduced Orange Pi 6 board. It is not proof.
The board silkscreen or a photo of the PCB would settle it.
