#!/bin/env bash
sudo docker run -ti --rm -e DISPLAY=$DISPLAY \
    --mount type=bind,source=/etc/machine-id,target=/etc/machine-id \
    --mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
    --mount type=bind,source=${HOME}/modelio-projects/workspace,target=/home/developer \
    --name modelio \
    --net=host \
    --user $(id -u):$(id -g) \
    -e HOME=/home/developer \
    -w /home/developer \
    modelio

