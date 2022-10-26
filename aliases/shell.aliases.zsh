# Shell commmands
alias c='clear'
alias e='exit'
alias tf='tail -f'
alias cat='batcat'

# Environment Reloading
reload_shell() {
  source ~/.zshrc
  if ! direnv status | grep -q "No .envrc found" ; then
    direnv reload
  fi
}

alias r='reload_shell'

# Undo auto-correct
alias lunchy='nocorrect lunchy'

# Alias a default Siege command
alias attack='siege -t20s -b -c1'
