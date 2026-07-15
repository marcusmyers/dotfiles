#!/usr/bin/env bash

set -euo pipefail

sudo apt-get update
sudo apt-get install -y \
    bat \
    composer \
    curl \
    fontconfig \
    git \
    gnupg \
    neovim \
    nodejs \
    npm \
    php-cli \
    php-sqlite3 \
    stow \
    unzip

if ! command -v nu >/dev/null 2>&1; then
    sudo install -d -m 0755 /etc/apt/keyrings
    curl -fsSL https://apt.fury.io/nushell/gpg.key \
        | sudo gpg --dearmor --yes -o /etc/apt/keyrings/fury-nushell.gpg
    echo "deb [signed-by=/etc/apt/keyrings/fury-nushell.gpg] https://apt.fury.io/nushell/ /" \
        | sudo tee /etc/apt/sources.list.d/fury-nushell.list >/dev/null
    sudo apt-get update
    sudo apt-get install -y nushell
fi

# Ubuntu/Debian sometimes install bat as `batcat`.
if ! command -v bat >/dev/null 2>&1 && command -v batcat >/dev/null 2>&1; then
    mkdir -p "$HOME/.local/bin"
    ln -sfn "$(command -v batcat)" "$HOME/.local/bin/bat"
fi
