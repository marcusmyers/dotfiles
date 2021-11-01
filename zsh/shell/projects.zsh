compctl -K _p p

_p() {
  local word words completions
  read -cA words
  word="$(words[2])"

  completions="$(ls $PROJECTS/)"

  reply=("${(ps:\n:)completions}")
}

function p {
  if [[ -d $PROJECTS/$1 ]]; then
    cd $PROJECTS/$1
  else
    echo "ERROR: $PROJECTS/$1 does not exist"
    return 1
  fi
  clear
}

alias mycode='p'

alias vimrc='vim ~/.vimrc'
alias dotfiles='cd ~/.dotfiles'
alias gabbro='cd ~/Code/gabbro'
alias manilla='cd ~/Code/manilla'
