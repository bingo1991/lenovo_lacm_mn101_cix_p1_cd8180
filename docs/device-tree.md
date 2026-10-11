# Device tree

## Goal

Describe the Lenovo LACM-MN101 in device tree form. The factory firmware
boots with ACPI. The tree is for documentation, comparison and DT work.

## Sources

| Source | Use |
| --- | --- |
| DSDT, SSDT1, SSDT2 | Board and SoC devices, addresses, interrupts, GPIO |
| `sky1.dtsi` | SoC description: CPUs, GIC, SCMI, I2C, SPI, UART, I3C, PCIe, pinctrl |
| Live system | Which buses and devices are active |

Two copies of `sky1.dtsi` exist in the Armbian build tree. The copy of the
cix-p1 6.18 kernel has no SPI, no pinctrl and no PCIe nodes. This repository
uses the newer copy that U-Boot v2026.07 imported from the Linux kernel.

## Board file

`dts/cix-sky1-lenovo-lacm-mn101.dts` adds:

1. model and compatible strings;
2. the memory map from /proc/iomem;
3. reserved memory: `ramoops` and the CMA pool;
4. GPIO LEDs, GPIO keys, three fixed regulators;
5. the enabled I2C buses and their devices;
6. the three used PCIe root ports;
7. the GPIO controllers, which `sky1.dtsi` does not describe yet;
8. extra compatible strings, so both the mainline and the CIX vendor
   drivers can probe.

Every node names its ACPI source. See `acpi-to-dt-mapping.md`.

## Build

```
make
```

Requirements: `cpp` and `dtc`. The binding headers are in `dts/include/`.
The build needs no kernel tree. The result is
`cix-sky1-lenovo-lacm-mn101.dtb`. The build is warning free.

## Status

| Part | State |
| --- | --- |
| Compile | clean |
| Hardware boot | not tested |
| PCIe, I2C, UART, pinctrl | mapped from ACPI and from the live system |
| GPIO and pinctrl consumers | bank and pin numbers not yet confirmed |
| Cameras, audio codec | absent on this SKU |
| Panel timings | not in ACPI. Read the EDID on the DP AUX bus. |

## Open items

1. Confirm the GPI pin number against the global pinctrl pin number.
2. Translate the MUX0 and MUX1 `PinGroup` vendor data.
3. Add the camera and codec nodes when a populated SKU appears.
4. Compare against the CIX vendor tree, branch `cix_p1_k6.6_master`.
