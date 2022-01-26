FROM docker.io/fedora:35 as common-pkgs
RUN dnf clean all
#RUN dnf -y install bash zsh sudo

FROM common-pkgs as base-pkgs
RUN dnf -y install procps-ng iputils iproute coreutils \
                   httpie socat bind-utils wireguard-tools  tmux zsh bash



FROM base-pkgs as fedora-binaries
COPY files/pueued-linux-x86_64-v1.0.6 /pueued
COPY files/pueue-linux-x86_64-v1.0.6 /pueue
COPY files/webhookserver-linux-amd64-v0.1.4 /webhookserver
RUN chmod 0700 /pueue /pueued /webhookserver
RUN chown root:root /pueue /pueued /webhookserver
RUN /pueue -h
RUN /pueued -h
RUN ls /webhookserver



FROM base-pkgs as iodine-builder
RUN dnf -y install gcc make git zlib-devel
ADD files/iodine-0.7.0.tar.gz /
WORKDIR /iodine-0.7.0
RUN make
RUN cp ./bin/iodine ./bin/iodined /


FROM docker.io/fedora:35 as fedora-webhookserver
ENV container=docker
COPY --from=fedora-binaries /webhookserver /usr/bin/webhookserver
RUN mkdir -p /root/.config
COPY files/webhook_server.yml /root/.config/webhook_server.yml
RUN chmod 600 /root/.config/webhook_server.yml
RUN chmod 0700 /usr/bin/webhookserver

FROM docker.io/fedora:35 as fedora-pueue
ENV container=docker
RUN dnf -y install procps-ng bash httpie iputils iproute socat zsh bind-utils wireguard-tools zsh tmux net-tools
RUN mkdir -p /root/.config/pueue
COPY files/pueue.yml /root/.config/pueue/pueue.yml
COPY --from=fedora-binaries /pueue /bin/pueue
COPY --from=fedora-binaries /pueued /bin/pueued
RUN chmod 0700 /bin/pueue /bin/pueued
RUN dnf -y install ansible openssh-clients
RUN dnf list > /.dnf
RUN dnf -y install ansible
COPY files/ssh_config /etc/ssh/ssh_config
RUN chmod 644 /etc/ssh/ssh_config
#COPY --from=fedora-binaries /webhookserver /bin/.
#COPY --from=iodine-builder /iodine /bin/.
#COPY --from=iodine-builder /iodined /bin/.
#COPY --from=builder /key.pem /root/.config/pueue/key.pem
#COPY --from=builder /cert.pem /root/.config/pueue/cert.pem
#RUN echo 'pueued -c ~/.config/pueue/pueue.yml --verbose' > /pueued.sh
#RUN echo 'webhookserver' > /webhookserver.sh
#RUN chmod 700 /pueued.sh /webhookserver.sh
#RUN chmod 600 /root/.config/pueue/key.pem /root/.config/pueue/key.pem
#COPY files/webhook_server.yml /root/.config/webhook_server.yml


FROM docker.io/restic/rest-server as fedora-restic-rest-server
RUN ls /
RUN cat /entrypoint.sh

FROM base-pkgs as fedora-iodine
RUN dnf -y install net-tools zsh tmux bash
COPY --from=iodine-builder /iodine /bin/iodine
COPY --from=iodine-builder /iodined /bin/iodined

