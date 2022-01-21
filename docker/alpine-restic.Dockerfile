FROM alpine:3.14 as alpine-restic
RUN apk add restic

FROM docker.io/restic/rest-server as alpine-restic-rest-server
RUN ls /


