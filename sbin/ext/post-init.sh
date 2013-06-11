#!/sbin/busybox sh
#
# Remount FileSys RW
/sbin/busybox mount -t rootfs -o remount,rw rootfs

echo "Running Post-Init Script"

## Testing: Check for ExFat SD Card
#
SDTYPE=`blkid /dev/block/mmcblk1p1  | awk '{ print $3 }' | sed -e 's|TYPE=||g' -e 's|\"||g'`

if [ ${SDTYPE} == "exfat" ];
then
  echo "ExFat-Debug: SD-Card is type ExFAT"
  echo "ExFat-Debug: trying to mount via fuse"
  mount.exfat-fuse /dev/block/mmcblk1p1 /storage/extSdCard
else
  echo "ExFat-Debug: SD-Card is type: ${SDTYPE}"
fi

# Remount FileSys RO
/sbin/busybox mount -t rootfs -o remount,ro rootfs

echo $(date) END of post-init.sh
