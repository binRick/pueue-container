FROM docker.io/restic/rest-server as fedora-restic
RUN ls /
RUN cat /entrypoint.sh


FROM fedora:35 as fedora-restic-rest-server
RUN dnf -y install bash zsh git rsync restic openssh-clients tcpdump ngrep
