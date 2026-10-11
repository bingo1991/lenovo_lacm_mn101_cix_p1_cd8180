# ACPI

## Tables

The firmware publishes 13 ACPI tables. All checksums are valid.
OEM ID is `CIXTEK`, OEM table ID is `SKY1EDK2`.

| Table | Bytes | Revision | Purpose |
| --- | --- | --- | --- |
| DSDT | 81257 | 2 | Main description |
| SSDT1 | 12500 | 2 | Board devices |
| SSDT2 | 5120 | 2 | CPU containers |
| FACP | 276 | 6 | Fixed description |
| APIC | 1064 | 5 | GIC interrupts |
| GTDT | 132 | 3 | Timers |
| IORT | 2776 | 5 | SMMU mapping |
| MCFG | 92 | 1 | PCIe ECAM |
| PPTT | 396 | 2 | CPU topology |
| PCCT | 138 | 2 | Shared communication |
| DBG2 | 92 | 0 | Debug port |
| CSRT | 140 | 0 | Core system resources |
| SDEI | 36 | 1 | Software delegated exceptions |

## Files

| File | Content |
| --- | --- |
| `acpi/raw/` | Raw tables from /sys/firmware/acpi/tables |
| `acpi/dsl/` | Decompiled DSDT, SSDT1 and SSDT2 |
| `acpi/acpidump.txt` | Full text dump |
| `acpi/table-summary.txt` | Header fields and checksum state |
| `acpi/checksums.md5` | MD5 of every raw table |
| `acpi/acpi-resources.txt` | Every device with address, IRQ and ID |
| `acpi/efibootmgr.txt` | Boot entries |

## Useful findings

1. Many devices use `_HID` `PRP0001` with a `_DSD` `compatible` string.
   Those devices are device tree style already. The device tree of this
   repository copies them.
2. DBG2 gives the debug port: namespace `\_SB.COM2`, base 0x040d0000,
   subtype 0x0003, an ARM SBSA UART. That is UART2 of the SoC.
3. The five root ports of the DSDT have distinct memory windows. The device
   tree maps each window to one `sky1.dtsi` PCIe node.
4. The firmware keeps an ESRT entry. The system firmware is updatable
   through a UEFI capsule. Current version 5, minimum version 3.
5. Secure Boot is enabled. PK, KEK, db and dbx exist.

## Not published

The EFI variable store is not in this repository. It holds platform keys,
the system serial number and the boot configuration. Only the boot entry
list is published, with the disk serial replaced.

## Recreate the dump

Run `tools/collect-acpi.sh` on the machine. The script needs `acpica-tools`
and passwordless sudo. It copies the tables, calls `acpidump` and `iasl`,
and packs the result.
