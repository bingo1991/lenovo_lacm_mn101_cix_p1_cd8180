#!/bin/bash
# Dump and decompile the ACPI tables on the CIX P1 board.
# Also back up the EFI variable store. Run as a user with passwordless sudo.

set -u

WORK=/tmp/cix-acpi
rm -rf "$WORK"
mkdir -p "$WORK"/{raw,dsl,text,efi}

echo "step 1: install acpica-tools"
sudo -n apt-get update -qq >"$WORK/text/apt-update.log" 2>&1
sudo -n apt-get install -y acpica-tools >"$WORK/text/apt-install.log" 2>&1
dpkg -l acpica-tools | tail -1 >"$WORK/text/acpica-version.txt"
command -v acpidump iasl >>"$WORK/text/acpica-version.txt" 2>&1

echo "step 2: dump tables with acpidump"
cd "$WORK/raw" || exit 1
for sig in DSDT SSDT1 SSDT2 FACP APIC GTDT IORT MCFG PPTT PCCT DBG2 CSRT SDEI; do
	sudo -n cp -a "/sys/firmware/acpi/tables/$sig" "$WORK/raw/$sig" 2>/dev/null
done
sudo -n cp -a /sys/firmware/acpi/tables/data/. "$WORK/raw/data/" 2>/dev/null
sudo -n chown -R "$(id -u):$(id -g)" "$WORK/raw"
sudo -n acpidump -o "$WORK/text/acpidump.txt" 2>&1 | tail -5
sudo -n acpidump -b -o "$WORK/raw" 2>&1 | tail -5

echo "step 3: decompile with iasl"
cd "$WORK/dsl" || exit 1
cp "$WORK/raw/DSDT" .
for f in "$WORK"/raw/SSDT*; do [ -f "$f" ] && cp "$f" "$WORK/dsl/$(basename "$f")"; done
for f in DSDT SSDT1 SSDT2; do
	[ -f "$f" ] || continue
	iasl -d "$f" >"$WORK/text/iasl-$f.log" 2>&1
done
chmod -R u+w "$WORK/dsl"

echo "step 4: back up EFI variables"
sudo -n tar -C /sys/firmware/efi/efivars -cf "$WORK/efi/efivars.tar" . 2>/dev/null
sudo -n chown "$(id -u):$(id -g)" "$WORK/efi/efivars.tar"
sudo -n efibootmgr -v >"$WORK/text/efibootmgr.txt" 2>&1
sudo -n tar -C /sys/firmware/efi/mok-variables -cf "$WORK/efi/mok-variables.tar" . 2>/dev/null
sudo -n chown "$(id -u):$(id -g)" "$WORK/efi/mok-variables.tar"
sudo -n tar -C /sys/firmware/efi/esrt -cf "$WORK/efi/esrt.tar" . 2>/dev/null
sudo -n chown "$(id -u):$(id -g)" "$WORK/efi/esrt.tar"
cp /sys/firmware/efi/fw_platform_size "$WORK/text/" 2>/dev/null

echo "step 5: pack"
ls -la "$WORK/raw" "$WORK/dsl" >"$WORK/text/listing.txt" 2>&1
tar -czf /tmp/cix-acpi-backup.tgz -C /tmp cix-acpi
ls -l /tmp/cix-acpi-backup.tgz
echo done
