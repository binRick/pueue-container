FROM alpine:3.14 as alpine-guard-builder
RUN apk add make go git bash
RUN git clone https://github.com/binRick/guard /usr/src/guard && cd /usr/src/guard && make && cp guard /

FROM alpine:3.14 as alpine-guard
RUN apk add httpie socat wireguard-tools zsh bash curl wget iptables
COPY --from=alpine-guard-builder /guard /usr/bin/guard
RUN chmod 0700 /usr/bin/guard
RUN mkdir /etc/wireguard

