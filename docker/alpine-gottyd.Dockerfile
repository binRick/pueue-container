FROM alpine:3.14 as alpine-ttyd
COPY files/gotty-1.0.1 /usr/bin/gotty
RUN chmod +x /usr/bin/gotty
RUN /usr/bin/gotty --help



