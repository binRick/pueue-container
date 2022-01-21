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

FROM alpine-base-pkgs as alpine-iodine
ADD files/iodine-0.7.0.tar.gz /
WORKDIR /iodine-0.7.0
RUN apk add zlib-dev automake gcc autoconf make libgsf-dev dev86 libc-dev musl-dev
RUN make
RUN cp bin/iodine /bin/iodine
RUN cp bin/iodined /bin/iodined
RUN chmod +x /bin/iodine /bin/iodined
RUN chown root:root /bin/iodine /bin/iodined

FROM alpine:3.14 as alpine-webhookserver
RUN mkdir -p /root/.config
ADD files/webhookserver-linux-amd64-v0.1.4 /bin/webhookserver
RUN chmod +x /bin/webhookserver
RUN chown root:root /bin/webhookserver
COPY files/webhook_server.yml /root/.config/webhook_server.yml
RUN chmod 600 /root/.config/webhook_server.yml
RUN chown root:root /root/.config/webhook_server.yml
EXPOSE 8000

FROM alpine:3.14 as alpine-pueue
#RUN apk add httpie socat wireguard-tools zsh bash curl wget
RUN mkdir -p /root/.config/pueue
ADD files/pueue-linux-x86_64-v1.0.6 /bin/pueue
ADD files/pueued-linux-x86_64-v1.0.6 /bin/pueued
RUN chmod +x /bin/pueue /bin/pueued
COPY files/pueue.yml /root/.config/pueue/pueue.yml
RUN chmod 600 /root/.config/pueue/pueue.yml
RUN chown root:root /root/.config/pueue/pueue.yml
#COPY --from=alpine-iodine /iodined /bin/iodined
#https://github.com/Nukesor/webhook-server/releases/download/v0.1.4/webhookserver-linux-amd64 /bin/webhookserver
#ADD https://github.com/Nukesor/pueue/releases/download/v1.0.4/pueued-linux-x86_64 /bin/pueued
#ADD https://github.com/Nukesor/pueue/releases/download/v1.0.4/pueue-linux-x86_64 /bin/pueue
#COPY files/pueue /bin/pueue
#COPY files/pueued /bin/pueued
#COPY files/webhookserver /bin/webhookserver
#COPY --from=alpine-builder /webhookserver /bin/.
#COPY --from=alpine-builder /key.pem /root/.config/pueue/key.pem
#COPY --from=alpine-builder /cert.pem /root/.config/pueue/cert.pem

#RUN echo '/bin/pueued -c /root/.config/pueue/pueue.yml -vv' > /pueued.sh
#RUN echo 'webhookserver' > /webhookserver.sh
#RUN chmod 700 /pueued.sh /webhookserver.sh

#RUN chmod 600 /root/.config/pueue/key.pem /root/.config/pueue/key.pem




#COPY files/webhook_server.yml /root/.config/webhook_server.yml




FROM alpine-base-pkgs as alpine-restic1
RUN apk add restic

FROM docker.io/restic/rest-server as alpine-restic
RUN ls /
