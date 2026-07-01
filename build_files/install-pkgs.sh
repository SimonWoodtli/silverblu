#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1
#
############################# LAYERED PKGS #############################
# Terminal helpers
LAYERED_PACKAGES=(
    atuin
    bat
    cheat
    grc
    ripgrep
    thefuck
    zoxide
    eza
    yq
    ugrep
    uutils-coreutils
    starship
    direnv
    chezmoi
    tealdeer
    gh
    pre-commit
    procs
    entr
    glow
    fzf
    pass
    xclip
    just
    neo
    cifs-utils
    nvme-cli


)
# General devel
LAYERED_PACKAGES+=(
    @development-tools
    ansible
    nodejs
    nodejs-npm
    pnpm
    yarnpkg
    bun
    exercism
    python3-pip
    pipx
    uv
    sqlite
)
# Settings/Operating System
LAYERED_PACKAGES+=(
    gnome-tweaks
    corectrl
    ydotool
    foot
    wofi
    ibus
    ibus-uniemoji
    samba-client
    borgbackup
    rclone
    git-lfs
)
# Editors
LAYERED_PACKAGES+=(
		vim
    helix
    neovim
)
# Benchmark
LAYERED_PACKAGES+=(
    bonnie++
)
# Virtualization
LAYERED_PACKAGES+=(
    virt-install
    virt-manager
    virt-viewer
    libvirt
    vagrant
)
# Container
LAYERED_PACKAGES+=(
    cosign
    devpod
    devpod-desktop
    podman-tui
    podman-compose
    podman-remote
    podlet
    distrobox
)
# Yubikey
LAYERED_PACKAGES+=(
    pamu2fcfg
    pam-u2f
    ykman
)
# Monitor
LAYERED_PACKAGES+=(
    btop
    nvtop
    smartmontools
    iotop
    sysstat
)
# Network
LAYERED_PACKAGES+=(
    macchanger
    nmap
    openssl
)
# Email
LAYERED_PACKAGES+=(
    neomutt
    isync
    msmtp
    notmuch
    urlview
    abook
)
# PDF
LAYERED_PACKAGES+=(
    qpdf
    mupdf
)
# Image
LAYERED_PACKAGES+=(
    feh
    qrencode
    gphoto2
)
# Music
LAYERED_PACKAGES+=(
    playerctl
    mpd
    mpc
    ncmpcpp
)
# Video
LAYERED_PACKAGES+=(
    cdrdao
    bchunk
    v4l-utils
    ffmpegthumbnailer
    ffmpeg
    ffmpeg-libs
)
# Library
LAYERED_PACKAGES+=(
    zstd
)
log "Installing RPM packages"
log "Install layered applications"
dnf5 install --setopt=install_weak_deps=False -y "${LAYERED_PACKAGES[@]}"

########################### LAYERED COPR PKGS ##########################
log "Enable Copr repos"
COPR_REPOS=(
    scottames/ghostty
    wezfurlong/wezterm-nightly
)
for repo in "${COPR_REPOS[@]}"; do
    dnf5 -y copr enable "$repo"
done

log "Install layered Copr packages"
for repo in "${COPR_REPOS[@]}"; do
LAYERED_PACKAGES=(
    ghostty
    wezterm
)
dnf5 install --setopt=install_weak_deps=False -y "${LAYERED_PACKAGES[@]}"

log "Disable Copr repos as we do not need it anymore"
for repo in "${COPR_REPOS[@]}"; do
    dnf5 -y copr disable "$repo"
done
