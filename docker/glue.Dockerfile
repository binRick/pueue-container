FROM docker.io/qmcgaw/gluetun as glue
RUN apk add curl bash zsh sudo git rsync socat wget httpie openssl
