FROM alpine:3.14 as alpine-common-pkgs
RUN apk update
RUN apk add bash zsh sudo


FROM alpine-common-pkgs as alpine-base-pkgs
#RUN dnf -y install procps-ng iputils iproute
#RUN dnf -y install httpie socat bind-utils 
#RUN dnf -y install openssh-clients rsync restic
#RUN dnf -y install wireguard-tools 
RUN apk add git rsync
RUN apk add wireguard-tools

FROM alpine-base-pkgs as alpine-compiler-pkgs
RUN apk add make cmake gcc automake autoconf

FROM alpine:3.14 as alpine-pueue-container

RUN mkdir -p /root/.config/pueue
COPY files/pueue /bin/pueue
COPY files/pueued /bin/pueued
COPY files/webhookserver /bin/webhookserver
#COPY --from=alpine-builder /webhookserver /bin/.
#COPY --from=alpine-builder /key.pem /root/.config/pueue/key.pem
#COPY --from=alpine-builder /cert.pem /root/.config/pueue/cert.pem


RUN echo 'pueued -c ~/.config/pueue/pueue.yml --verbose' > /pueued.sh
RUN echo 'webhookserver' > /webhookserver.sh
RUN chmod 700 /pueued.sh /webhookserver.sh

#RUN chmod 600 /root/.config/pueue/key.pem /root/.config/pueue/key.pem


RUN apk add httpie socat wireguard-tools zsh bash curl wget


COPY files/pueue.yml /root/.config/pueue/pueue.yml
COPY files/webhook_server.yml /root/.config/webhook_server.yml
RUN chmod 600 /root/.config/pueue/pueue.yml /root/.config/webhook_server.yml

EXPOSE 8000
