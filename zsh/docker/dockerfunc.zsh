# All the docker functions
dcleanup(){
  docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
  docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

del_stopped(){
  local name=$1
  local state=$(docker inspect --format "{{.State.Running}}" $name 2>/dev/null)

  if [[ "$state" == "false" ]]; then
    docker rm $name
  fi
}

mkthumbnail()
{
  del_stopped mkthumb

  docker run -d \
    -v `pwd`:/data \
    --name mkthumb \
    -w="/data" \
    jess/imagemagick \
    convert -define jpeg:size=500x180 $1 -auto-orient -thumbnail 250x90 -unsharp 0x.5 $2
}

http()
{
  del_stopped httpie

  docker run --rm \
    --log-driver none \
    --name httpie \
    jess/httpie "$@"
}

# composer()
# {
#   docker run --rm \
#     --volume `pwd`:/data \
#     --workdir /data \
#     --entrypoint "/usr/local/bin/composer" marcusmyers/composer:1.5.4 $@
# }

relies_on(){
  local containers=$@

  for container in $containers; do
    local state=$(docker inspect --format "{{.State.Running}}" $container 2>/dev/null)

    if [[ "$state" == "false" ]] || [[ "$state" == "" ]]; then
      echo "$container is not running, starting it for you."
      $container
    fi
  done
}

aws(){
  del_stopped awscli

  docker run -it --rm \
    -v $HOME/.aws:/root/aws \
    --log-driver none \
    --name awscli \
    jess/awscli "$@"
}

notify_osd(){
  del_stopped notify_osd

  docker run -d \
    -v /etc/machine-id:/etc/machine-id:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /var/run/dbus:/var/run/dbus \
    -v /var/run/user/$(id -u):/var/run/user/$(id -u) \
    $(env | cut -d= -f1 | awk '{print "-e", $1}') \
    -e DISPLAY=unix$DISPLAY \
    -e DBUS_SESSION_BUS_ADDRESS="unix:path=/var/run/user/1000/bus" \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    -u $(whoami) -w "$HOME" \
    -v /home/mark/.Xauthority:/home/mark/.Xauthority \
    --name notify_osd \
    jess/notify-osd
}

alias notify-send=notify_send
notify_send(){
  relies_on notify_osd
  local args=${@:2}

  docker exec -i notify_osd notify-send "$1" "${args}"
}
