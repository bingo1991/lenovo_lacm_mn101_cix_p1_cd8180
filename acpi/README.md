# ACPI data

Dump from one Lenovo LACM-MN101, firmware BIOS-V1.03.

| Path | Content |
| --- | --- |
| `raw/` | Raw tables from /sys/firmware/acpi/tables |
| `dsl/` | Decompiled `iasl` output for DSDT, SSDT1 and SSDT2 |
| `acpidump.txt` | Text dump of every table |
| `table-summary.txt` | Signature, length, revision, OEM fields, checksum state |
| `checksums.md5` | MD5 of every file in `raw/` |
| `acpi-resources.txt` | Device list with HID, address and interrupt |
| `efibootmgr.txt` | Boot entries |

The raw files keep the names of the ACPI directory. SSDT1 and SSDT2 are two
tables with the same signature.

## Decompile

```
sudo apt install acpica-tools
for t in DSDT SSDT1 SSDT2; do iasl -d "$t"; done
```

The decompiled files are byte identical in meaning to the raw tables. The
DSDT source is about 21 000 lines.

## Content

The tables hold no serial number and no MAC address. The only device
identifier was the disk name in `efibootmgr.txt`. It is replaced.

See [../docs/acpi.md](../docs/acpi.md) for the table list and the findings.

## License

The tables are Lenovo and CIX firmware content. See [../NOTICE.md](../NOTICE.md).
