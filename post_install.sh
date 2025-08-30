#!/usr/bin/env bash

set -e
set -o pipefail

paru -Syu

systemctl --user enable --now pipewire
systemctl --user enable --now pipewire-pulse
systemctl --user enable --now wireplumber

# AUR packages
paru -S --sudoloop --needed \
    google-chrome \
    tmatrix \
    pipes.sh \

sudo systemctl enable --now auto-cpufreq

# From CachyOS
sudo pacman -S --noconfirm --needed \
    cachyos-gaming-meta \
    cachyos-gaming-applications \
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

# Important packages
sudo pacman -S --noconfirm --needed \
    7zip \
    base \
    base-devel \
    bat \
    brightnessctl \
    btop \
    cronie \
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
    git \
    gnome-keyring \
    gtk3 \
    hyprcursor \
    hyprland \
    hyprlang \
    hyprlock \
    hyprpaper \
    hyprpicker \
    hyprpolkitagent \
    hyprshot \
    hyprsunset \
    hyprutils \
    hyprwayland-scanner \
    intel-ucode \
    imagemagick \
    kitty \
    lf \
    lib32-gcc-libs \
    lib32-glibc \
    linux \
    linux-firmware \
    linux-headers \
    luarocks \
    man-db \
    man-pages \
    neovim \
    net-tools \
    networkmanager \
    npm \
    openssh \
    pkgfile \
    python-pip \
    qt5-wayland \
    qt6-wayland \
    rclone \
    reflector \
    ripgrep \
    rofi-wayland \
    sbctl \
    stow \
    swaync \
    texinfo \
    trash-cli \
    wine \
    wl-clipboard \
    wtype \
    xdg-desktop-portal-hyprland \

# Optional (nice to have packages, but not used by any dotfiles)
sudo pacman -S --noconfirm --needed \
    at \
    blueman \
    docker \
    duf \
    freerdp \
    gdu \
    ghidra \
    globalprotect-openconnect \
    gpu-screen-recorder-gtk \
    gthumb \
    keepassxc \
    libreoffice-fresh \
    lolcat \
    nix \
    ntfs-3g \
    okular \
    qalculate-qt \
    qemu-full \
    qemu-user \
    tealdeer \
    valgrind \
    virt-manager \
    virt-viewer \
    vlc \
    vlc-plugins-all \
    wireshark-qt \
    youtube-music \

