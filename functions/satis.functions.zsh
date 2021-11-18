if [ -z "$COMPOSER_HOME"]; then
  export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
fi

function satis(){
  docker run --rm --init -it \
    --user $(id -u):$(id -g) \
    --volume $(pwd):/build \
    --volume "${COMPOSER_HOME:-$HOME/.composer}:/composer" \
    composer/satis $1 $2 $3
}
