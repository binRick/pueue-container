# syntax = edrevo/dockerfile-plus

FROM alpine:3.14 as alpine-pueue-img

RUN mkdir -p /root/.config/pueue
ADD files/pueue-linux-x86_64-v1.0.6 /usr/bin/pueue
ADD files/pueued-linux-x86_64-v1.0.6 /usr/bin/pueued
RUN chmod +x /usr/bin/pueue /usr/bin/pueued
COPY files/pueue.yml /root/.config/pueue/pueue.yml
RUN chmod 600 /root/.config/pueue/pueue.yml
RUN chown root:root /root/.config/pueue/pueue.yml

RUN apk add rsync git socat ansible wget \
            curl wireguard-tools httpie bash \
            podman-remote docker-cli \
            openssh-client zsh bash sudo \
            ripgrep vim jq \
            nagios-plugins-ssh nagios-plugins-tcp \
            nagios-plugins-dig nagios-plugins-fping \
            nagios-plugins-http nagios-plugins-dns nagios-plugins-by_ssh \
            nagios-plugins-ping nagios-plugins-ssl_validity nagios-plugins-icmp
RUN apk add ansible-base-doc go

RUN env GO111MODULE=on go install github.com/DarthSim/hivemind@latest
RUN mv /root/go/bin/hivemind /usr/bin/hivemind
COPY files/Procfile /.Procfile
COPY files/hivemind.env /etc/profile.d/hivemind.sh
RUN apk add ttyd iputils iproute2 drill
RUN go get github.com/Depau/ttyc/cmd/ttyc
RUN mv /root/go/bin/ttyc /usr/bin/ttyc
ADD https://github.com/binRick/shox/raw/master/releases/shox.musl /usr/bin/shox
RUN chmod +x /usr/bin/shox

RUN mkdir -p ~/.config/shox
COPY files/shox.conf ~/.config/shox/config.yaml

RUN apk list > /.apk
SHELL ["/bin/zsh"]
COPY files/ssh_config /etc/ssh/ssh_config
COPY files/gopath.sh /etc/profile.d/gopath.sh

INCLUDE+ alpine-guard.Dockerfile

FROM alpine-pueue-img as alpine-pueue
RUN apk add file zsh bash fish

COPY files/webhookserver-linux-amd64-v0.1.4 /usr/bin/webhookserver
COPY files/webhook_server.yml /root/.config/webhook_server.yml

COPY --from=alpine-guard-builder /guard /usr/bin/guard

INCLUDE+ resolvers.Dockerfile
