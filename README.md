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
    * alacritty
    * fsarchiver
    * glances
    * inxi
    * meld
    * nano-syntax-highlighting
    * pv
    * python-defusedxml
    * python-packaging
    * rsync
    * vi
    * micro
    * nano
10. Deselect whichever ucode package isn't needed under `CPU specific Microcode update packages`
11. Deselect `Firefox and language package` and go `Next`
12. Fill in the user info
13. Review the info and press `Install`, then `Install Now`
14. Reboot to the new system
15. Log in with the new username and password
16. Clone this repo, `git clone https://github.com/SteelCerberus/dotfiles.git`
17. `cd dotfiles`
18. `sudo ./install.sh`
19. `reboot` and log in

## Post-Installation
1. `cd dotfiles`
2. `./post_install.sh` and follow any instructions
3. Overwrite existing .config with `cp -r .config ..`. If using this repo going forward, skip this step and follow the instructions at the end for setting up `stow`.
4. Modify `/etc/systemd/system/gdrive.service` and `/etc/systemd/system/netshare.service` to have the correct username (i.e., replace `steel` with the current username)
5. Use `rclone config` or copy over old rclone config
6. `sudo systemctl enable --now gdrive.service`
7. `sudo systemctl enable --now netshare.service`
8. Add to `crontab -e`:
* `* * * * * [ $(cat /sys/class/power_supply/BAT0/capacity) -lt 20 ] && [ "$(cat /sys/class/power_supply/BAT0/status)" = "Discharging" ] && DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send -u normal "Battery Low"`
9. Add user to any groups (e.g., `wheel`, `kvm`, `docker`, `nix-users`, `wireshark`, `libvirt`)
10. GitHub ssh config:
```bash
/bin/bash
cd
mkdir -p .ssh
ssh-keygen -t ed25519 -C "email@gmail.com"
wl-copy < ~/.ssh/id_ed25519.pub
# Now add that to GitHub

# If using multiple GitHub accounts, do that process for each account, then create an ssh config:
vim ~/.ssh/config

Host *
    IdentitiesOnly yes

Host personal
    HostName github.com
    IdentityFile ~/.ssh/personal_id_ed25519

Host work
    HostName github.com
    IdentityFile ~/.ssh/work_id_ed25519

# Now, git can be used like this:
git clone git@personal:User/repo.git

# Then in a repo, always do this:
cd repo
git config user.name "Personal Name"
git config user.email "personal@gmail.com"
```
11. `reboot`
12. Log in, then `Hyprland` 

### Stow
```bash
cd
rm -rf dotfiles
git clone git@personal:SteelCerberus/dotfiles.git .dotfiles
cd .dotfiles
# This creates symlinks for the files not in .stow-local-ignore
stow .
```

