FROM alpine:3.14 as alpine-ttyd
RUN apk add restic
RUN apk add ttyd



