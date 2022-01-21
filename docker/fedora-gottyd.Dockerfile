FROM docker.io/fedora:35 as fedora-gottyd

RUN dnf -y install wget curl
ADD https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz /
RUN ls /
