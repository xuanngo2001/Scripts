# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
#/dev/mapper/auto--install-root /               ext4    errors=remount-ro 0       1
#none / tmpfs defaults 0 0
none / tmpfs defaults 0 0
# /boot was on /dev/sda1 during installation
UUID=2c4d2368-1ba1-49ac-91dc-4ccdf49cdd87 /boot           ext2    defaults        0       2
/dev/mapper/auto--install-home /home           ext4    defaults        0       2
/dev/mapper/auto--install-tmp /tmp            ext4    defaults        0       2
/dev/mapper/auto--install-usr /usr            ext4    defaults        0       2
/dev/mapper/auto--install-var /var            ext4    defaults        0       2
/dev/mapper/auto--install-swap_1 none            swap    sw              0       0
/dev/sr0        /media/cdrom0   udf,iso9660 user,noauto     0       0