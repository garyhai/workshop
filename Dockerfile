FROM centos:centos6

MAINTAINER Gary Hai "gary@XL59.com"

# update and installation
RUN yum -y update
RUN yum -y install openssh-server

# set default locale
#RUN echo 'LANG="en_US.UTF-8"' >> /etc/default/locale

# generate default configuration.
RUN service sshd start
RUN service sshd stop

# very simple password for root
RUN echo "root:root" | chpasswd

#export ssh server port
EXPOSE 22

CMD /usr/sbin/sshd -D
