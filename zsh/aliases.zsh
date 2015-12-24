alias reload!='. ~/.zshrc'

# Logging stuff.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $@"; }

alias homestead='cd ~/Homestead && vagrant'
alias dclean='docker rm `docker ps -a -q -f status=exited`'
alias diclean='docker rmi `docker images -q -f dangling=true`'
