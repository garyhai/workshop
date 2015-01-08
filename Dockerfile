FROM centos:centos6

MAINTAINER Gary Hai "gary@XL59.com"

# update to latest version of centos6
RUN yum -y update

# install sshd
RUN yum -y install openssh-server
# generate default configuration.
RUN service sshd start
RUN service sshd stop

# very simple password for root
RUN echo "root:root" | chpasswd

# install deps
RUN yum -y install git gcc tar make

# clone erlang with HEAD checkout and build it
RUN mkdir -p /usr/local/src;\
    cd /usr/local/src;\
    git clone https://github.com/erlang/otp.git;\
    cd otp;\
    ./otp_build autoconf;\
    ./configure;\
    make;\
    make install

#export ssh server port
EXPORT 22

CMD /usr/sbin/sshd -D
