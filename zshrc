#  MMMMMMMM               MMMMMMMM
#  M:::::::M             M:::::::M
#  M::::::::M           M::::::::M
#  M:::::::::M         M:::::::::M
#  M::::::::::M       M::::::::::M   ooooooooooo xxxxxxx      xxxxxxx
#  M:::::::::::M     M:::::::::::M oo:::::::::::oox:::::x    x:::::x
#  M:::::::M::::M   M::::M:::::::Mo:::::::::::::::ox:::::x  x:::::x
#  M::::::M M::::M M::::M M::::::Mo:::::ooooo:::::o x:::::xx:::::x
#  M::::::M  M::::M::::M  M::::::Mo::::o     o::::o  x::::::::::x
#  M::::::M   M:::::::M   M::::::Mo::::o     o::::o   x::::::::x
#  M::::::M    M:::::M    M::::::Mo::::o     o::::o   x::::::::x
#  M::::::M     MMMMM     M::::::Mo::::o     o::::o  x::::::::::x
#  M::::::M               M::::::Mo:::::ooooo:::::o x:::::xx:::::x
#  M::::::M               M::::::Mo:::::::::::::::ox:::::x  x:::::x
#  M::::::M               M::::::M oo:::::::::::oox:::::x    x:::::x
#  MMMMMMMM               MMMMMMMM   ooooooooooo xxxxxxx      xxxxxxx
#
#
#
#           Personal .zshrc file of Mark Myers <mark.myers@hey.com>
#

# Configuration {{{
# ==============================================================================

  ssh-add -l
  if [[ $? -ne 0 ]]; then
    eval $(ssh-agent)
    ssh-add -k
  fi
# }}}

# Interactive shell startup scripts {{{
# ==============================================================================

    if [[ $- == *i* && $0 == '/usr/bin/zsh' ]]; then
        ~/.dotfiles/scripts/login.sh
    fi

    if [[ `echo $SHELL` == '/bin/zsh' ]]; then
        ~/.dotfiles/scripts/login-mac.sh
    fi

# }}}

  # shortcut to this dotfiles path is $DOTFILES
  export ZSH=$HOME/.oh-my-zsh
  export DOTFILES=$HOME/.dotfiles
  export DEFAULT_USER=$USER
  # your project folder that we can `c [tab]` to
  if [[ `uname` == 'Darwin' ]]; then
  export PROJECTS=$HOME/Documents/Code
  else
  export PROJECTS=$HOME/Code
  fi
  export PATH="$HOME/.bin:$PATH"

  plugins=(git)
  source $ZSH/oh-my-zsh.sh
  if [[ -d "~/.fonts" ]]; then
    source ~/.fonts/*.sh
  fi

  # Stash your environment variabls in ~/.secrets
  if [[ -a ~/.secrets ]]; then
    source ~/.secrets
  fi

  # load the aliases files
  for path_file ($DOTFILES/paths/*.path.zsh(.N)) source $path_file

  if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/mark.json)"
  fi

  if [[ -v TMUX ]]; then
    tmux set -g window-status-format '#I:#{b:pane_current_path}'
    tmux set -g window-status-current-format '#I@#{b:pane_current_path}'
    tmux set -g status-left ' '
    tmux set -g status-right ' %Y-%m-%d %H:%M:%S '
  fi
# }}}

# Aliases & Functions {{{
# ==============================================================================

  # load the aliases files
  for alias_file ($DOTFILES/aliases/*.aliases.zsh(.N)) source $alias_file

  # load the function files
  for func_file ($DOTFILES/functions/*.functions.zsh(.N)) source $func_file

# }}}

# vim: set nospell foldmethod=marker foldlevel=0:
