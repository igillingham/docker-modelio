FROM centos:7
MAINTAINER Ian Gillingham - Diamond Light Source
# RUN cut -d: -f1 /etc/group | sort
RUN groupadd -g 37238 developer
RUN useradd -r -u 37238 -g developer developer
#USER developer
#RUN echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#RUN echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd
#RUN echo "developer:x:${uid}:" >> /etc/group
COPY ./modelio-open-source3.8-3.8.1.el7.x86_64.rpm / 
COPY ./modelio-archimate3.8-3.8.1.noarch.rpm / 
RUN yum install -y modelio-open-source3.8-3.8.1.el7.x86_64.rpm
RUN yum install -y modelio-archimate3.8-3.8.1.noarch.rpm
RUN rm *.rpm
# Replace 0 with your user / group id
#RUN export uid=32738 gid=32738
RUN mkdir -p /home/developer
#RUN chmod 0440 /etc/sudoers
# ENV HOME /home/developer
CMD modelio-open-source3.8 --workspace /home/developer
