FROM docker.io/restic/rest-server as fedora-ttyd
RUN DNF -y install ttyd
