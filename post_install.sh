#!/usr/bin/env bash

set -e
set -o pipefail

paru -Syu

# AUR packages
paru -S --sudoloop --needed \
    google-chrome \
    tmatrix \

sudo systemctl enable --now auto-cpufreq

# From CachyOS
sudo pacman -S --noconfirm --needed \
    cachyos-gaming-meta \
    auto-cpufreq \  # usually in AUR
sudo pacman -Rns plymouth cachyos-plymouth-bootanimation

# Any other before the big install
curl -s https://ohmyposh.dev/install.sh | bash -s

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
sudo mkdir -p /usr/share/fonts/FiraCode
sudo mkdir -p /usr/share/fonts/JetBrainsMono
sudo unzip FiraCode.zip -d /usr/share/fonts/FiraCode
sudo unzip JetBrainsMono.zip -d /usr/share/fonts/JetBrainsMono
rm FiraCode.zip JetBrainsMono.zip
sudo fc-cache -f -v

sudo mkdir -p /mnt/drive/
sudo mkdir -p /mnt/netshare/
sudo chown -R $USER /mnt/drive /mnt/netshare
sudo mv gdrive.service netshare.service /etc/systemd/system

# Big install
sudo pacman -S --noconfirm --needed \
    7zip \
    at \
    base \
    base-devel \
    bat \
    blueman \
    brightnessctl \
    btop \
    cmatrix \
    cronie \
    docker \
    duf \
    edk2-shell \
    efibootmgr \
    efitools \
    eza \
    fastfetch \
    fd \
    fish \
    fisher \
    fuse3 \
    fzf \
    gdb \
    gdu \
    ghidra \
    git \
    gnome-keyring \
    gtk3 \
    hyprcursor \
    hyprland \
    hyprlang \
    hyprlock \
    hyprpaper \
    hyprpicker \
    hyprshot \
    hyprsunset \
    hyprutils \
    hyprwayland-scanner \
    intel-ucode \
    keepassxc \
    kitty \
    lf \
    lib32-gcc-libs \
    lib32-glibc \
    libreoffice-fresh \
    linux \
    linux-firmware \
    linux-headers \
    luarocks \
    man-db \
    man-pages \
    neovim \
    net-tools \
    networkmanager \
    nix \
    npm \
    okular \
    openssh \
    pkgfile \
    polkit-kde-agent \
    python-pip \
    qalculate-qt \
    qemu-full \
    qemu-user \
    qt5-wayland \
    qt6-wayland \
    rclone \
    reflector \
    ripgrep \
    rofi-wayland \
    sbctl \
    swaync \
    tealdeer \
    texinfo \
    trash-cli \
    valgrind \
    virt-manager \
    virt-viewer \
    wine \
    wireshark-qt \
    wl-clipboard \
    wtype \
    xdg-desktop-portal-hyprland \

