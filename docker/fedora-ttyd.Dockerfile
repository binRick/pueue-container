FROM docker.io/fedora:35 as fedora-ttyd
RUN dnf -y install cmake make gcc automake autoconf
ADD files/ttyd-1.6.3.tar.gz /
WORKDIR /ttyd-1.6.3
RUN dnf -y install zlib-devel
RUN dnf -y install libuv-devel
RUN cmake . && make -j
RUN ls
