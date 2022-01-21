FROM docker.io/fedora:35 as fedora-ttyd
RUN dnf -y install cmake make gcc automake autoconf
ADD files/ttyd-1.6.3.tar.gz /
WORKDIR /ttyd-1.6.3
RUN cmake . && make -j
RUN ls
