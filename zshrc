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

  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
  
  # shortcut to this dotfiles path is $DOTFILES
  export ZSH=$HOME/.oh-my-zsh
  export DOTFILES=$HOME/.dotfiles
  export ZSH_THEME="powerlevel10k/powerlevel10k"
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

  # zsh theme setup
  POWERLEVEL9K_MODE='awesome-fontconfig'
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
  POWERLEVEL9K_CONTEXT_TEMPLATE="%m"

  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time aws docker_machine ram battery)
  POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M \uf073 %m/%d/%y}"
  POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='\u2570'$'\U2500\uf0da  '

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
