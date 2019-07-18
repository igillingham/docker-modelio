Building Modelio Docker Image
=============================

Copy RPM files to this directory
--------------------------------
Building the Docker image required the Modelio and ArchiMate RPMs to be available at build time.
At the time of writing, the files were:

modelio-open-source3.8-3.8.1.el7.x86_64.rpm
modelio-archimate3.8-3.8.1.noarch.rpm

These can be freely downloaded from the Modelio web site (https://www.modelio.org)

You should end up with the contents of the build directory looking like this:

Dockerfile
modelio-archimate3.8-3.8.1.noarch.rpm
modelio-open-source3.8-3.8.1.el7.x86_64.rpm
modelio.sh 


Build the Modelio image
-----------------------
sudo docker build -t modelio .


Run an image
------------
There a shell script - modelio.sh, which packages up a lot of the host system
mappings (if you want to be able to save your UML projects).
A brief breakdown of the scripts is given below:

#!/bin/env bash
sudo docker run -ti --rm -e DISPLAY=$DISPLAY \
    --mount type=bind,source=/etc/machine-id,target=/etc/machine-id \
    --mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
    --mount type=bind,source=/home/ig43/.Xauthority,target=${HOME}/.Xauthority \
    --mount type=bind,source=/home/ig43/modelio-projects/workspace,target=/home/developer \
    --name modelio \
    --net=host \
    --user $(id -u):$(id -g) \
    -e HOME=/home/developer \
    modelio \
    "$@"

All the DISPLAY, X11, machine-id and Xauthority stuff is to allow the container to render to
the host display - worth noting for future reference, as it took a bit of trial
and error to find the right formula.

The default user inside the container is 'developer' and is mapped to my own
user and group ids. This will need changing for other users, in both the
Dockerfile and run-script.

The internal directory /home/developer is mapped to the host director
/home/ig43, but should be modified to the user's own home directory (or wherever
is suitable).

