FROM alpine-base-pkgs as alpine-restic
RUN apk add restic

FROM docker.io/restic/rest-server as alpine-restic-rest-server
RUN ls /


