FROM alpine:3.14 as alpine-pueue
#RUN apk add httpie socat wireguard-tools zsh bash curl wget
RUN mkdir -p /root/.config/pueue
ADD files/pueue-linux-x86_64-v1.0.6 /usr/bin/pueue
ADD files/pueued-linux-x86_64-v1.0.6 /usr/bin/pueued
RUN chmod +x /usr/bin/pueue /usr/bin/pueued
COPY files/pueue.yml /root/.config/pueue/pueue.yml
RUN chmod 600 /root/.config/pueue/pueue.yml
RUN chown root:root /root/.config/pueue/pueue.yml
