#!/bin/bash

# 2025 by mira-miracoli (GitHub)
# Checks if SLX detected the root disk, set it up correctly and mounted the scratch storage

dmsetup="/dev/mapper/scratch * type=1
/dev/mapper/tank * type=1
/dev/mapper/root / type=1"
disk_setup=0
if [ "$(cat /run/openslx/dmsetup.state | grep -v "#" | cut -d, -f 1)" = "$dmsetup" ]; then
    disk_setup=1
fi

# Check for OPENSLX_SYS partition label
openslx_label=0
if blkid | grep -qs "OPENSLX_SYS"; then
    openslx_label=1
fi

# Check that scratch is mounted
scratch=0
SCRATCH_MOUNT=/scratch
if [ "$disk_setup" ] && df | grep -qs "$SCRATCH_MOUNT"; then
    scratch=1
fi

echo "pxe.disk_mode,host=$(cat /etc/hostname) openslx_label=$openslx_label,scratch_mounted=$scratch,disksetup_ok=$disk_setup"
