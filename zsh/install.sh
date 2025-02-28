#!/bin/zsh
#
# Oh-My-Zsh
#
# This installs oh-my-zsh

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "  Installing oh-my-zsh for you."

  KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install oh-my-posh
brew install jandedobbeleer/oh-my-posh/oh-my-posh

exit 0
