# SteelCerberus's dotfiles
## Pre-Installation
Check for x86_64 Microarchitecture Level Support to determine if the Cachy repos will be useful:
`/lib/ld-linux-x86-64.so.2 --help | grep supported`

[Download the ISO](https://cachyos.org/download/)

Verify the ISO integrity:
`sha256sum cachyos-desktop-linux-250713.iso`

Enter `Setup Mode` from the UEFI firmware. Use `systemctl restart --firmware-setup`. If `Setup Mode` isn't an option, the equivalent is disabling Secure Boot clear the platform keys.

Flash the ISO to a USB drive with [balenaEtcher](https://etcher.balena.io/)

## Installation
Boot from the USB drive.

1. Once booted, start the installer (`Launch installer`)
2. Select `Refind` for the Bootloader
3. Choose the appropriate language
4. Choose the appropriate timezone
5. Choose the appropriate keyboard
6. Select the default partition/filesystem scheme by pressing `Next`
7. Select `No Desktop`
8. Deselect `CachyOS shell configuration`
9. Under `Base-devel + Common packages`, deselect the following:
* X-system
* desktop integration
* Under `some applications selection`, deselect:
** alacritty
** fsarchiver
** glances
** inxi
** meld
** nano-syntax-highlighting
** pv
** python-defusedxml
** python-packaging
** rsync
** vi
** micro
** nano
10. Deselect whichever ucode package isn't needed under `CPU specific Microcode update packages`
11. Deselect `Firefox and language package` and go `Next`
12. Fill in the user info
13. Review the info and press `Install`, then `Install Now`
14. Reboot to the new system

## Post-Installation
1. Log in with the new username and password
2. Clone this repo, `git clone https://github.com/SteelCerberus/dotfiles.git`
3. `cd dotfiles`
4. `sudo ./install.sh`

