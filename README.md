
Motivation for creating this Modelio Docker Image
=================================================
After a recent upgrade to Redhat Enterprise Linux 7, I found that I was no
longer able to run my favourite UML modelling tool, Modelio.  the GTK libraries
appear not to be compatible.  So I decided to attempt to run Modelio inside a Docker image, based on a Linux distribution that is supported.  I did so and it works well.


Building Modelio Docker Image
=============================

Copy RPM files to this directory
--------------------------------
Building the Docker image require the Modelio and ArchiMate RPMs to be available at build time.
At the time of writing, the files were:

modelio-open-source3.8-3.8.1.el7.x86_64.rpm
modelio-archimate3.8-3.8.1.noarch.rpm

These can be freely downloaded from the Modelio web site (https://www.modelio.org)

You should end up with the contents of the build directory looking like this:

Dockerfile
modelio-archimate3.8-3.8.1.noarch.rpm
modelio-open-source3.8-3.8.1.el7.x86_64.rpm
modelio.sh 

It is quite likely that a newer version will be available at the time of reading
this, which should be downloaded from the Modelio web site. Then edit the RPM
file names in the Docker file and rebuild the images, as below.

Naturally I have specifically not included the RPMs in this repository.
 

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
    --mount type=bind,source=${HOME}/modelio-projects/workspace,target=/home/developer \
    --name modelio \
    --net=host \
    --user $(id -u):$(id -g) \
    -e HOME=/home/developer \
    -w /home/developer \
    modelio

All the DISPLAY, X11 and machine-id stuff is to allow the container to render to
the host display - worth noting for future reference, as it took a bit of trial
and error to find the right formula.

The default user inside the container is 'developer' and is mapped to the
session user and group ids.

The internal directory /home/developer is mapped to the host user's home directory, but could be mapped to any specific directory on the host system. 
