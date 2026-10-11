#!/bin/bash
# Collect a hardware inventory on the CIX P1 board.
# Run as a user that has passwordless sudo.

set -u

OUT=${OUT:-/tmp/cix-hwinfo}
rm -rf "$OUT"
mkdir -p "$OUT"/{cmd,acpi,efi,sys,log}

# save NAME COMMAND... : run one command and store its output.
save() {
	local name="$1"
	shift
	{
		printf '$ %s\n' "$*"
		"$@" 2>&1
	} >"$OUT/cmd/${name}.txt"
}

# sh_save NAME STRING : run one shell string and store its output.
sh_save() {
	local name="$1" cmd="$2"
	{
		printf '$ %s\n' "$cmd"
		bash -c "$cmd" 2>&1
	} >"$OUT/cmd/${name}.txt"
}

echo "collecting: identity"
save uname uname -a
save os-release cat /etc/os-release
save kernel /proc/version
save cmdline cat /proc/cmdline
save uptime uptime
save date date

echo "collecting: cpu and memory"
save cpuinfo cat /proc/cpuinfo
save lscpu lscpu
save lscpu-e lscpu -e
save free free -h
save meminfo cat /proc/meminfo
save interrupts cat /proc/interrupts
save iomem sudo -n cat /proc/iomem
save cpufreq sh -c 'ls /sys/devices/system/cpu/cpufreq/ 2>/dev/null; cat /sys/devices/system/cpu/cpufreq/policy0/* 2>/dev/null'

echo "collecting: firmware and DMI"
save dmidecode sudo -n dmidecode
save dmi-bios sudo -n dmidecode -t bios
save dmi-system sudo -n dmidecode -t system
save dmi-baseboard sudo -n dmidecode -t baseboard
save dmi-chassis sudo -n dmidecode -t chassis
save dmi-processor sudo -n dmidecode -t processor
save dmi-memory sudo -n dmidecode -t memory
save dmi-cache sudo -n dmidecode -t cache
save dmi-slot sudo -n dmidecode -t slot
save dmi-tpm sudo -n dmidecode -t 43
save fwupd fwupdmgr get-devices
save fwupd-json fwupdmgr get-devices --json
save fwupd-version fwupdmgr --version

echo "collecting: PCI and USB"
save lspci lspci -nnn
save lspci-v lspci -nnn -vvv
save lspci-tree lspci -tv
save lsusb lsusb
save lsusb-tree lsusb -tv
save lsusb-v lsusb -v

echo "collecting: storage"
save lsblk lsblk -o NAME,MAJ:MIN,SIZE,TYPE,FSTYPE,MOUNTPOINT,MODEL,SERIAL,TRAN,ROTA
save lsblk-json lsblk -J -O
save blockdev sfdisk -l
save mtd cat /proc/mtd
save mtd-dev sh -c 'ls -l /dev/mtd* 2>/dev/null'
save nvme sudo -n nvme list
save nvme-smart sudo -n nvme smart-log /dev/nvme0

echo "collecting: network"
save ip-addr ip -j addr
save ip-link ip -j link
save ip-route ip route
save ethtool sh -c 'for i in $(ls /sys/class/net); do echo "== $i =="; sudo -n ethtool -i $i; done'
save lspci-net lspci -nnn -d ::0200

echo "collecting: graphics and multimedia"
save drm sh -c 'for d in /sys/class/drm/*; do echo "== $d =="; cat $d/status 2>/dev/null; done'
save fb cat /proc/fb
save v4l2 sh -c 'ls -l /dev/video* /dev/media* 2>/dev/null'
save vulkan vulkaninfo --summary
save glxinfo sh -c 'DISPLAY=:0 glxinfo -B'

echo "collecting: misc buses and sensors"
save i2c sh -c 'ls -l /sys/bus/i2c/devices/'
save spi sh -c 'ls -l /sys/bus/spi/devices/'
save gpio sh -c 'ls /sys/class/gpio/ 2>/dev/null; cat /sys/kernel/debug/gpio 2>/dev/null'
save thermal sh -c 'for z in /sys/class/thermal/thermal_zone*; do echo "== $z =="; cat $z/type $z/temp; done'
save hwmon sh -c 'for h in /sys/class/hwmon/*; do echo "== $h =="; cat $h/name 2>/dev/null; done'
save sensors sensors -u
save usb-tree lsusb -t
save bluetooth bluetoothctl list

echo "collecting: kernel messages"
save dmesg sudo -n dmesg
save journal-kernel sudo -n journalctl -k -b
save journal-warn sudo -n journalctl -p warning -b

echo "collecting: lshw"
save lshw sudo -n lshw
save lshw-short sudo -n lshw -short
save lshw-json sudo -n lshw -json

echo "collecting: ACPI tables"
sudo -n cp -a /sys/firmware/acpi/tables/. "$OUT/acpi/" 2>/dev/null
sudo -n chown -R "$(id -u):$(id -g)" "$OUT/acpi"
save acpi-list sh -c "ls -la $OUT/acpi/"
sh_save acpi-sigs "for f in $OUT/acpi/*; do printf '%-10s %s\n' \"\$(basename \$f)\" \"\$(dd if=\$f bs=1 count=8 status=none)\"; done"
sh_save acpi-sums "cd $OUT/acpi && for f in *; do [ -f \$f ] && printf '%s %s\n' \"\$(md5sum \$f | cut -d' ' -f1)\" \"\$f\"; done"

echo "collecting: EFI data"
save efi-systab cat /sys/firmware/efi/systab
save efi-platform-size cat /sys/firmware/efi/fw_platform_size
save efi-esrt sudo -n hexdump -C /sys/firmware/efi/esrt/entries/entry0/* 2>/dev/null
save efivars-list sh -c "ls -1 /sys/firmware/efi/efivars/ | sed 's/-[0-9a-f-]*\$//' | sort -u"
save efi-bootentries sh -c 'sudo -n efibootmgr -v'
save mok-vars sh -c 'sudo -n ls -la /sys/firmware/efi/mok-variables/ 2>/dev/null'

echo "collecting: device tree fragments"
save devicetree sh -c 'ls /sys/firmware/devicetree/base 2>/dev/null | head -50'
save of-nodes sh -c 'ls /proc/device-tree 2>/dev/null | head -50'

echo "collecting: packages and modules"
save dpkg-short sh -c 'dpkg -l | awk "{print \$2\" \"\$3}" | head -400'
save lsmod lsmod
save modules-custom sh -c 'ls /lib/modules/$(uname -r)/updates/ 2>/dev/null'
save dkms dkms status
save installed-kernels sh -c 'dpkg -l | grep -E "linux-image|linux-headers|armbian-firmware|armbian-bsp"'

echo "packing"
tar -czf /tmp/cix-hwinfo.tgz -C "$(dirname "$OUT")" "$(basename "$OUT")"
ls -l /tmp/cix-hwinfo.tgz
echo "done"
