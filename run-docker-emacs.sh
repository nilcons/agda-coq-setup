#!/bin/bash

set -eu

build_remapped_image() {
    DEMO_UID=$1
    DEMO_GID=$2
    image=$3

    dir=$(mktemp -d)
    cat > $dir/Dockerfile <<EOF
FROM klao/agda-coq:latest
USER root
ARG DEMO_UID=$DEMO_UID
ARG DEMO_GID=$DEMO_GID
RUN /root/remap-demo-ids.sh
USER demo
EOF
    docker build --tag=agda-coq-$DEMO_UID-$DEMO_GID $dir
    rm -rf $dir
}


image=klao/agda-coq

uid=$(id -u)
gid=$(id -g)
if [[ "$uid:$gid" != "1000:1000" ]]; then
    image="agda-coq-$uid-$gid"
    if ! docker images | grep -q "^$image "; then
        echo "Need to build $image"
        build_remapped_image $uid $gid $image
    fi
fi

if [[ -n "$DISPLAY" ]]; then
    XAUTHORITY=${XAUTHORITY:-$HOME/.Xauthority}
    innner_xauthority=/home/demo/.Xauthority
    exec docker run -it --rm --network=host --ipc=host --shm-size=4g -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v $XAUTHORITY:$innner_xauthority -v $HOME:$HOME -e DISPLAY -e XAUTHORITY=$innner_xauthority $image bash -i -c emacs
else
    exec docker run -it --rm -v $HOME:$HOME $image bash -i -c emacs
fi
