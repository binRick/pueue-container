FROM docker.io/fedora:35 as fedora-client
RUN dnf -y install zsh bash curl rsync openssl bash wget
