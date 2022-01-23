FROM alpine:3.14 as alpine-client
RUN apk add bash zsh rsync git openssl curl wget
