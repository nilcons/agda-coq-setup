#!/bin/bash

set -eu

cd $(dirname $0)

image="agda-coq-$USER"

if ! docker images | grep -q "^$image "; then
    echo "Need to build $image"

    export DEMO_UID=$(id -u)
    export DEMO_GID=$(id -g)
    export WORKDIR=$HOME
    docker build --build-arg DEMO_UID --build-arg DEMO_GID --build-arg WORKDIR --tag=$image --file docker/Dockerfile.remap docker/
fi

if [[ -n "$DISPLAY" ]]; then
    XAUTHORITY=${XAUTHORITY:-$HOME/.Xauthority}
    innner_xauthority=/home/demo/.Xauthority
    exec docker run -it --rm --network=host --ipc=host --shm-size=4g -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v $XAUTHORITY:$innner_xauthority -v $HOME:$HOME -e DISPLAY -e XAUTHORITY=$innner_xauthority $image bash -i -c emacs
else
    exec docker run -it --rm -v $HOME:$HOME -e TERM=xterm-256color $image bash -i -c emacs
fi
