
FROM alpine-base-pkgs as alpine-builder

#RUN dnf -y install bash systemd
#RUN dnf -y install iputils iproute socat zsh bind-utils openssh-clients openssh-server procps-ng
#RUN dnf -y install authselect-devel authselect-libs authselect

#COPY daemontools-encore-1.11-1.fc36.x86_64.rpm /.
#RUN dnf -y install /daemontools-encore-1.11-1.fc36.x86_64.rpm


#RUN dnf -y install wireguard-tools
#RUN dnf -y install golang automake autoconf
#RUN dnf -y install libseccomp libseccomp-static libseccomp-devel
#RUN dnf -y install pam-devel
#RUN dnf -y install authselect rsync
#RUN dnf -y install sssd-client restic
RUN apk list > /.apk
RUN apk del cargo rust
RUN apk add libgcc


ADD https://sh.rustup.rs /rust.sh
RUN sh /rust.sh -y

WORKDIR /usr/src
RUN git clone https://github.com/Nukesor/pueue-webhook-server
RUN git clone https://github.com/nukesor/pueue
WORKDIR /usr/src/pueue

RUN apk add gcc        make         gcc         g++         zlib         zlib-dev         python3         ldc

RUN ~/.cargo/bin/cargo install --locked pueue
WORKDIR /usr/src/pueue-webhook-server
RUN ~/.cargo/bin/cargo install --path . 

#RUN find ~/.cargo/bin
RUN cp ~/.cargo/bin/pueue /.
RUN cp ~/.cargo/bin/pueued /.
RUN cp ~/.cargo/usr/bin/webhookserver /.
RUN apk add openssl
#RUN openssl req -nodes -new -x509 -keyout /key.pem -out /cert.pem


