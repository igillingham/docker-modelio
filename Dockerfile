FROM centos:7
MAINTAINER Ian Gillingham - Diamond Light Source
COPY ./modelio-open-source3.8-3.8.1.el7.x86_64.rpm / 
COPY ./modelio-archimate3.8-3.8.1.noarch.rpm / 
RUN yum install -y modelio-open-source3.8-3.8.1.el7.x86_64.rpm
RUN yum install -y modelio-archimate3.8-3.8.1.noarch.rpm
RUN rm *.rpm
RUN mkdir -p /home/developer
CMD modelio-open-source3.8 --workspace /home/developer
