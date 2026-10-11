# Hardware inventory

Command output from one Lenovo LACM-MN101, kernel 7.0.0-38-cix.

| Path | Content |
| --- | --- |
| `inxi.txt` | `inxi -Faz -v 8` |
| `i2c.txt` | I2C bus list and `i2cdetect` for every bus |
| `cmd/` | 80 command outputs: dmidecode, lspci, lsusb, lshw, dmesg, ip, ethtool, sensors and more |

## Collect again

```
scp tools/collect.sh user@host:/tmp/
ssh user@host 'bash /tmp/collect.sh'
scp user@host:/tmp/cix-hwinfo.tgz .
```

The script needs passwordless sudo on the target. It writes
`/tmp/cix-hwinfo.tgz`.

## Sanitized values

Every device identifier is replaced. The placeholders are:

| Placeholder | Original |
| --- | --- |
| `<SYSTEM-SERIAL>` | System serial number |
| `<CPU-SERIAL>` | CPU serial number |
| `<NVME-SERIAL>` | NVMe serial number |
| `<PANEL-SERIAL>` | Panel serial number |
| `<UUID>` | Disk UUID and PARTUUID |
| `<MAC>` | MAC address of every interface |
| `<GLOBAL-IPV6>` | Global IPv6 address |
| `<LINK-LOCAL-IPV6>` | Link local IPv6 address |
| `user` | Login name of the operator |

Run `tools/sanitize.sh` after a new collection. Keep the value list out of
the repository. See `tools/redact.list.example`.

## Warnings

`cmd/journal-kernel.txt` and `cmd/dmesg.txt` are large. They contain the
boot log of the machine.
