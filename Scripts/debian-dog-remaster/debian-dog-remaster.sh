#!/bin/sh
# Description: Create a custom live Debian operating system. It will create an ISO.
#               The main idea is to replace the SQUASHFS file with a custom one.
# Author: Xuan Ngo
# Usage:
#   Change the following parameters accordingly:
#     -EXTRACTED_ISO_DIR: Location you want the extract ISO to be located.
#     -ISO_FILE_PATH: Location of the original DebianDog ISO.
#     -NEW_SQUASHFS: Location of the new SQUASHFS file generated by RemasterDog application ran within Debian Dog.

### Extract ISO.
EXTRACTED_ISO_DIR=/media/sf_vm_sharedfolder/moddebdogdir
ISO_FILE_PATH=/media/sf_vm_sharedfolder/DebianDog-Wheezy-openbox_xfce.iso
./extract-deb-iso.sh ${ISO_FILE_PATH} ${EXTRACTED_ISO_DIR}

# Replace squashfs
SQUASHFS=${EXTRACTED_ISO_DIR}/live/01-filesystem.squashfs
NEW_SQUASHFS=/media/sf_vm_sharedfolder/01-remaster.squashfs
yes | cp ${NEW_SQUASHFS} ${SQUASHFS}

### Add persistence boot entry
cat boot-entry.txt >> ${EXTRACTED_ISO_DIR}/isolinux/live.cfg

### Make ISO
DATE_STRING=`date +"%Y-%m-%d_%0k.%M.%S"`
OUTPUT_ISO_DIR=/media/sf_vm_sharedfolder
OUTPUT_ISO=${OUTPUT_ISO_DIR}/cust-debdog-${DATE_STRING}.iso

# Make ISO
rm -f ${OUTPUT_ISO}
genisoimage  -r -V "cust-debdog" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ${OUTPUT_ISO} ${EXTRACTED_ISO_DIR}


# Display info
echo "***************** Done *****************"
echo "Created ${OUTPUT_ISO}."