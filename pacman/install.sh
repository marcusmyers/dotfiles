#!/usr/bin/env bash

set -euo pipefail

packages=(
    bat
    composer
    curl
    git
    kitty
    neovim
    nodejs
    npm
    nushell
    php
    php-sqlite
    stow
)

install_package() {
    local package="$1"
    pacman -Q "$package" >/dev/null 2>&1 && return 0

    if command -v omarchy >/dev/null 2>&1; then
        # Omarchy tracks package changes and applies its own migrations through
        # this command, which is preferable to updating through pacman directly.
        omarchy pkg add "$package"
    else
        sudo pacman -S --noconfirm --needed "$package"
    fi
}

for package in "${packages[@]}"; do
    install_package "$package"
done

# Keep the existing prompt when this package is available in the configured
# Arch/Omarchy repositories. Nushell has a good native prompt if it is not.
if pacman -Si oh-my-posh-bin >/dev/null 2>&1; then
    install_package oh-my-posh-bin
fi
