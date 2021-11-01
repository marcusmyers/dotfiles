alias dclean='docker rm `docker ps -a -q -f status=exited`'
alias diclean='docker rmi `docker images -q -f dangling=true`'
alias dc='docker-compose'
alias dcphpunit='dc run --rm app vendor/bin/phpunit'
