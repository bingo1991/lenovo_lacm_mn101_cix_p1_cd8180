#!/bin/bash
# Benchmark suite for the Lenovo LACM-MN101 (CIX Sky1 / CD8180).
# Run as a user with passwordless sudo. Run time is about 9 minutes.
# Writes /tmp/cix-bench.tgz and /tmp/cix-bench-extra.tgz.

set -u

OUT=${OUT:-/tmp/cix-bench}
EXTRA=${EXTRA:-/tmp/cix-bench-extra}
rm -rf "$OUT" "$EXTRA"
mkdir -p "$OUT"/{cpu,memory,disk,gpu,thermal,env} "$EXTRA"

run() {
	local dir="$1" name="$2"
	shift 2
	echo "== $name"
	"$@" >"$OUT/$dir/$name.txt" 2>&1 || echo "   failed: $name"
}

echo "step 1: environment"
run env uname uname -a
run env lscpu lscpu
run env cpufreq sh -c 'for p in /sys/devices/system/cpu/cpufreq/policy*; do echo "== $p"; cat $p/related_cpus $p/scaling_governor $p/scaling_min_freq $p/scaling_max_freq; done'
run env cpufreq-before sh -c 'for c in 0 4; do echo "cpu$c $(cat /sys/devices/system/cpu/cpu$c/cpufreq/scaling_cur_freq)"; done'
run env thermal-idle sh -c 'for z in /sys/class/thermal/thermal_zone*; do printf "%s %s %s\n" "$(basename $z)" "$(cat $z/type)" "$(cat $z/temp)"; done'
run env free free -m
run env df df -h /
run env nvme-model sh -c 'cat /sys/block/nvme0n1/device/model 2>/dev/null; cat /sys/block/nvme0n1/queue/scheduler 2>/dev/null'

echo "step 2: CPU, sysbench"
for t in 1 4 8 12; do
	run cpu "sysbench-cpu-$t" sysbench cpu --threads="$t" --time=15 --events=0 run
done
run cpu sysbench-threads-12 sysbench threads --threads=12 --time=10 --thread-yields=100 --thread-locks=4 run

echo "step 3: CPU, 7-Zip"
run cpu 7z-single 7z b -mmt1
run cpu 7z-multi 7z b -mmt12

echo "step 4: memory"
run memory sysbench-memory-1 sysbench memory --threads=1 --time=10 --memory-block-size=1M --memory-total-size=20G run
run memory sysbench-memory-12 sysbench memory --threads=12 --time=10 --memory-block-size=1M --memory-total-size=20G run
for i in 1 2 3; do
	run memory "mbw-run$i" mbw -n 5 -q 256
done

echo "step 5: thermal and frequency under load"
stress-ng --cpu 12 --timeout 60s --metrics-brief >"$OUT/thermal/stress-ng.txt" 2>&1 &
spid=$!
: >"$OUT/thermal/thermal.csv"
echo "seconds,cpu0_mhz,cpu4_mhz,coretemp_max_c,nvme_c,z0,z1,z2,z3,z4" >"$OUT/thermal/thermal.csv"
for s in $(seq 0 5 60); do
	c0=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
	c4=$(cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq)
	core=$(cat /sys/class/hwmon/hwmon1/temp1_input 2>/dev/null || echo 0)
	nvme=$(cat /sys/class/hwmon/hwmon6/temp1_input 2>/dev/null || echo 0)
	z="$(cat /sys/class/thermal/thermal_zone0/temp) $(cat /sys/class/thermal/thermal_zone1/temp) $(cat /sys/class/thermal/thermal_zone2/temp) $(cat /sys/class/thermal/thermal_zone3/temp) $(cat /sys/class/thermal/thermal_zone4/temp)"
	echo "$s,$((c0 / 1000)),$((c4 / 1000)),$((core / 1000)),$((nvme / 1000)),$(echo $z | tr ' ' ',')" >>"$OUT/thermal/thermal.csv"
	[ "$s" = 60 ] || sleep 5
done
wait $spid 2>/dev/null
run thermal thermal-after sh -c 'for z in /sys/class/thermal/thermal_zone*; do printf "%s %s\n" "$(cat $z/type)" "$(cat $z/temp)"; done'

echo "step 6: storage, fio"
FIO=/data/cix-bench-fio.bin
sudo -n rm -f "$FIO"
fio_common="--ioengine=libaio --direct=1 --time_based --group_reporting --ramp_time=3 --output-format=json"
run disk seqread-1M-qd16 sudo -n fio --name=seqread --filename="$FIO" --rw=read --bs=1M --numjobs=4 --iodepth=16 --size=1G --runtime=20 $fio_common
run disk seqwrite-1M-qd16 sudo -n fio --name=seqwrite --filename="$FIO" --rw=write --bs=1M --numjobs=4 --iodepth=16 --size=512M --runtime=20 $fio_common
run disk randread-4k-qd32 sudo -n fio --name=randread --filename="$FIO" --rw=randread --bs=4k --numjobs=4 --iodepth=32 --size=512M --runtime=20 $fio_common
run disk randwrite-4k-qd32 sudo -n fio --name=randwrite --filename="$FIO" --rw=randwrite --bs=4k --numjobs=4 --iodepth=32 --size=512M --runtime=20 $fio_common
run disk randread-4k-qd1 sudo -n fio --name=randread1 --filename="$FIO" --rw=randread --bs=4k --numjobs=1 --iodepth=1 --size=256M --runtime=15 $fio_common
run disk mixreadwrite-70-30 sudo -n fio --name=mix --filename="$FIO" --rw=randrw --rwmixread=70 --bs=4k --numjobs=4 --iodepth=32 --size=512M --runtime=20 $fio_common
sudo -n rm -f "$FIO"

echo "step 7: GPU, glmark2"
run gpu glmark2-wayland sh -c 'XDG_RUNTIME_DIR=/run/user/1000 WAYLAND_DISPLAY=wayland-0 glmark2-es2-wayland --off-screen -b :duration=3 2>&1 | tail -20'
run gpu glmark2-x11 sh -c 'DISPLAY=:0 XAUTHORITY=/run/user/1000/gdm/Xauthority glmark2 --off-screen -b :duration=3 2>&1 | tail -20'
run gpu vulkaninfo vulkaninfo --summary

echo "step 8: cluster split"
mbw -n 5 -q 256 >"$EXTRA/mbw-all.txt" 2>&1
taskset -c 2,3,4,5 sysbench cpu --threads=4 --time=15 run >"$EXTRA/sysbench-cpu-a520.txt" 2>&1
taskset -c 0,1,6,7,8,9,10,11 sysbench cpu --threads=8 --time=15 run >"$EXTRA/sysbench-cpu-a720.txt" 2>&1
taskset -c 2,3,4,5 sysbench memory --threads=4 --time=10 --memory-block-size=1M --memory-total-size=20G run >"$EXTRA/sysbench-memory-a520.txt" 2>&1

echo "packing"
tar czf /tmp/cix-bench.tgz -C /tmp cix-bench
tar czf /tmp/cix-bench-extra.tgz -C /tmp cix-bench-extra
ls -l /tmp/cix-bench.tgz /tmp/cix-bench-extra.tgz
echo done
