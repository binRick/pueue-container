FROM fedora:latest as common-pkgs
RUN dnf clean all
RUN dnf -y install bash zsh sudo

FROM common-pkgs as base-pkgs
RUN dnf -y install procps-ng iputils iproute coreutils
RUN dnf -y install httpie socat bind-utils 
#RUN dnf -y install openssh-clients rsync restic
RUN dnf -y install wireguard-tools 

FROM base-pkgs as builder

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
RUN sh -c 'dnf list > /.dnf'



ADD https://sh.rustup.rs /rust.sh
RUN sh /rust.sh -y

RUN dnf -y install git
RUN dnf -y remove cargo rust
WORKDIR /usr/src
RUN git clone https://github.com/Nukesor/pueue-webhook-server
RUN git clone https://github.com/nukesor/pueue
WORKDIR /usr/src/pueue

RUN ~/.cargo/bin/cargo install --locked pueue
WORKDIR /usr/src/pueue-webhook-server
RUN ~/.cargo/bin/cargo install --path . 

RUN find ~/.cargo/bin
RUN cp ~/.cargo/bin/pueue /.
RUN cp ~/.cargo/bin/pueued /.
RUN cp ~/.cargo/bin/webhookserver /.
RUN dnf -y install openssl
RUN openssl req -nodes -new -x509 -keyout /key.pem -out /cert.pem



FROM base-pkgs as daemontools-builder
RUN dnf -y install gcc make git
WORKDIR /
RUN git clone https://github.com/binRick/daemontools-encore-rpm
WORKDIR /daemontools-encore-rpm
RUN sh ./build.sh 1.11



FROM fedora:latest as pueue-container

RUN mkdir -p /root/.config/pueue
COPY --from=builder /pueue /bin/.
COPY --from=builder /pueued /bin/.
COPY --from=builder /webhookserver /bin/.
COPY --from=builder /key.pem /root/.config/pueue/key.pem
COPY --from=builder /cert.pem /root/.config/pueue/cert.pem


RUN echo 'pueued -c ~/.config/pueue/pueue.yml --verbose' > /pueued.sh
RUN echo 'webhookserver' > /webhookserver.sh
RUN chmod 700 /pueued.sh /webhookserver.sh
RUN chmod 600 /root/.config/pueue/key.pem /root/.config/pueue/key.pem


RUN dnf -y install procps-ng bash httpie iputils iproute socat zsh bind-utils wireguard-tools


COPY files/pueue.yml /root/.config/pueue/pueue.yml
COPY files/webhook_server.yml /root/.config/webhook_server.yml
RUN chmod 600 /root/.config/pueue/pueue.yml /root/.config/webhook_server.yml


