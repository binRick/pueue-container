FROM alpine:3.14 as alpine-ttyd
RUN apk add ttyd zsh bash fish
