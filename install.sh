#!/usr/bin/env bash

set -e
set -o pipefail

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Script must be ran as root."
    exit 1
fi

###############################################################################
### Install necessary dependencies
###############################################################################

echo "Installing core packages"
pacman -S --noconfirm --needed \
    efitools \
    edk2-shell \
    intel-ucode \
    mkinitcpio \
    sbctl \
    wget \
    efibootmgr \
    jq \
    parted \

###############################################################################
### Prepare for Secure Boot
###############################################################################

# https://unix.stackexchange.com/a/768774
EFIDISK="/dev/$(lsblk --json --tree --inverse |
    jq -r '
.blockdevices[] |
    if .mountpoints[] == "/boot" then
        .. |
            if .children? then
                empty
            else
                .name // empty
            end
    else
        empty
    end
')"
EFIPART="$(parted ${EFIDISK} print | grep 'boot, esp' | cut -d ' ' -f 2)"
echo "Detected EFI disk: $EFIDISK, EFI partition: $EFIPART"

echo "Downloading BTRFS UEFI driver to /boot/btrfs.efi"
wget -q https://github.com/maharmstone/btrfs-efi/releases/download/20230328/btrfs-amd64.efi
mv btrfs-amd64.efi /boot/btrfs.efi

efibootmgr --driver --create --disk "$EFIDISK" --part "$EFIPART" --label "BTRFS Driver" --loader "\btrfs.efi"
echo "Created driver entry for BTRFS UEFI"

cp /usr/share/edk2-shell/x64/Shell_Full.efi /boot/shellx64.efi
efibootmgr --create --disk "$EFIDISK" --part "$EFIPART" --label "UEFI Shell" --loader "\shellx64.efi"
echo "Created boot entry for UEFI Shell"

# Backup Secure Boot variables
for EFIVAR in PK KEK db dbx ; do 
    efi-readvar -v $EFIVAR -o old_${EFIVAR}.esl
done
echo "Saved EFI Secure Boot variables to old_(PK, KEK, db, dbx).esl"

if ! sbctl status | grep "Setup Mode" | grep -q "Enabled"; then
    echo "Not in Setup Mode. Boot to firmware with 'systemctl reboot --firmware-setup' and enter Setup Mode (clear Platform Key and disable Secure Boot)."
    exit 1
fi

###############################################################################
### Modify mkinitcpio to create a Unified Kernel Image (UKI)
###############################################################################

# The UKI contains the kernel parameters usually passed by the bootloader
# mkinitcpio looks in the /etc/cmdline.d directory for the params
# Since rEFInd is already installed, we can copy its kernel parameters
mkdir /etc/cmdline.d
head –lines 1 /boot/refind_linux.conf | cut -d '"' -f 4 > /etc/cmdline.d/root.conf

# The EFI partition is mounted at /boot
# We need to create the /EFI/boot directory in the EFI partition to place bootx64.efi as a fallback
mkdir -p /boot/EFI/boot

cat << EOF > /etc/mkinitcpio.d/linux.preset
ALL_kver="$(pacman -Qql linux-cachyos | grep 'vmlinuz$')"

# Uncomment to generate a fallback
# PRESETS=('default' 'fallback')
PRESETS=('default')

default_uki="/boot/EFI/boot/cachyos.efi"
default_options="--splash /usr/share/systemd/bootctl/splash-arch.bmp"

fallback_uki="/boot/EFI/boot/bootx64.efi"
fallback_options="-S autodetect"
EOF

# Regenerate all presets to create the UKI
mkinitcpio -P

# Create boot entry for the UKI
efibootmgr --create --disk "$EFIDISK" --part "$EFIPART" --label "CachyOS UKI" --loader "\EFI\boot\cachyos.efi"
echo "Created boot entry for CachyOS UKI"

# Clean up the now unnecessary files
rm "/boot/vmlinuz*" "/boot/intel-ucode.img" "/boot/initramfs-*.img"

# Delete all traces of rEFInd
efibootmgr -B -b "$(efibootmgr | grep -i refind | cut -f 1 -d ' ' | cut -f 1 -d '*' | cut -f 2 -d 't')"
pacman -Rns refind-btrfs refind
rm -rf /boot/refind_linux.conf /boot/EFI/refind

###############################################################################
### Enroll Secure Boot keys and sign EFI binaries
###############################################################################

sbctl create-keys
sbctl enroll-keys --microsoft --firmware-builtin

for EFIBINARY in /boot/btrfs.efi /boot/shellx64.efi /boot/EFI/boot/cachyos.efi; do
    sbctl sign -s "$EFIBINARY"
    sbctl verify "$EFIBINARY" | grep -q "is signed"
done

# Just for users to see
sbctl verify

echo "Installation complete! Ready to reboot the system."
echo "Old Secure Boot variables are saved at old_(PK, KEK, db, dbx).esl. These can be deleted if a reboot is successful."

