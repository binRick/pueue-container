FROM alpine:3.14 as alpine-common-pkgs
RUN apk update
RUN apk add bash zsh sudo


FROM alpine-common-pkgs as alpine-base-pkgs
#RUN dnf -y install procps-ng iputils iproute
#RUN dnf -y install httpie socat bind-utils 
#RUN dnf -y install openssh-clients rsync restic
#RUN dnf -y install wireguard-tools 
RUN apk add git rsync
RUN apk add wireguard-tools

FROM alpine-base-pkgs as alpine-compiler-pkgs
RUN apk add make cmake gcc automake autoconf

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
RUN cp ~/.cargo/bin/webhookserver /.
RUN apk add openssl
#RUN openssl req -nodes -new -x509 -keyout /key.pem -out /cert.pem



FROM alpine:3.14 as alpine-pueue-container

RUN mkdir -p /root/.config/pueue
COPY --from=alpine-builder /pueue /bin/.
COPY --from=alpine-builder /pueued /bin/.
COPY --from=alpine-builder /webhookserver /bin/.
#COPY --from=alpine-builder /key.pem /root/.config/pueue/key.pem
#COPY --from=alpine-builder /cert.pem /root/.config/pueue/cert.pem


RUN echo 'pueued -c ~/.config/pueue/pueue.yml --verbose' > /pueued.sh
RUN echo 'webhookserver' > /webhookserver.sh
RUN chmod 700 /pueued.sh /webhookserver.sh

#RUN chmod 600 /root/.config/pueue/key.pem /root/.config/pueue/key.pem


RUN apk add httpie socat wireguard-tools zsh bash curl wget


COPY files/pueue.yml /root/.config/pueue/pueue.yml
COPY files/webhook_server.yml /root/.config/webhook_server.yml
RUN chmod 600 /root/.config/pueue/pueue.yml /root/.config/webhook_server.yml

EXPOSE 8000
