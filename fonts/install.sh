#!/bin/bash

mkdir -p $HOME/.fonts

if [ `uname` == "Darwin" ]; then
  curl -sSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o ~/Library/Fonts/MesloLGS\ NF\ Regular.ttf
  curl -sSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o ~/Library/Fonts/MesloLGS\ NF\ Bold.ttf
  curl -sSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o ~/Library/Fonts/MesloLGS\ NF\ Italic.ttf
  curl -sSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o ~/Library/Fonts/MesloLGS\ NF\ Bold\ Italic.ttf
else
  curl -sSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o ~/.fonts/MesloLGS\ NF\ Regular.ttf
  curl -sSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o ~/.fonts/MesloLGS\ NF\ Bold.ttf
  curl -sSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o ~/.fonts/MesloLGS\ NF\ Italic.ttf
  curl -sSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o ~/.fonts/MesloLGS\ NF\ Bold\ Italic.ttf
fi

if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi
