#!/usr/bin/env bash

set -e
set -o pipefail

paru -Syu

# AUR packages
paru -S --sudoloop --needed \
    auto-cpufreq \
    google-chrome \

sudo systemctl enable --now auto-cpufreq

# From CachyOS-PKGBUILDS
sudo pacman -S --noconfirm --needed \
    cachyos-gaming-meta \

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
    texinfo \
    tldr \
    trash-cli \
    valgrind \
    virt-manager \
    virt-viewer \
    wget \
    wine \
    wireshark-qt \
    wl-clipboard \
    wtype \
    xdg-desktop-portal-hyprland \

