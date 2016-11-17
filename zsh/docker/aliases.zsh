alias dclean='docker rm `docker ps -a -q -f status=exited`'
alias diclean='docker rmi `docker images -q -f dangling=true`'
