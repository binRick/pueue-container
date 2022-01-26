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


RUN apk list > /.apk
SHELL ["/bin/zsh"]
COPY files/ssh_config /etc/ssh/ssh_config
COPY files/gopath.sh /etc/profile.d/gopath.sh

FROM alpine-pueue-img as alpine-pueue

COPY files/webhookserver-linux-amd64-v0.1.4 /usr/bin/webhookserver
COPY files/webhook_server.yml /root/.config/webhook_server.yml

