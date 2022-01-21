FROM docker.io/fedora:35 as fedora-ttyd
RUN dnf -y install ttyd
