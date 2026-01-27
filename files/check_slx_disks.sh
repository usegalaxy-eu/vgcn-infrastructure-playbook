#!/bin/bash

# 2025 by mira-miracoli (GitHub)
# Checks if SLX detected the root disk, set it up correctly and mounted the scratch storage
# The nfs label is just as a hint that nfs is hanging, a "2" does not guarantee working NFS.

dmsetup="/dev/mapper/scratch * type=1
/dev/mapper/tank * type=1
/dev/mapper/root / type=1"
disk_setup=0
timeout_sec=10

if [ "$(cat /run/openslx/dmsetup.state | grep -v "#" | cut -d, -f 1)" = "$dmsetup" ]; then
            disk_setup=1
fi

# Check for OPENSLX_SYS partition label
openslx_label=0
if timeout $timeout_sec blkid | grep -qs "OPENSLX_SYS"; then
            openslx_label=1
fi

# Check that scratch is mounted
scratch=0
SCRATCH_MOUNT=/scratch
if [ "$disk_setup" ] && timeout $timeout_sec df | grep -qs "$SCRATCH_MOUNT"; then
            scratch=1
fi
timeout $timeout_sec df >> /dev/null && nfs=2 || nfs=0
echo "pxe.disk_mode,host=$(cat /etc/hostname) openslx_label=$openslx_label,scratch_mounted=$scratch,disksetup_ok=$disk_setup,nfs=$nfs"
