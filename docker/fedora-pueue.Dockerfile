FROM docker.io/fedora:35 as common-pkgs
RUN dnf clean all
RUN dnf -y install bash zsh sudo

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


FROM docker.io/fedora:35 as fedora-pueue
ENV container=docker
RUN dnf -y install procps-ng bash httpie iputils iproute socat zsh bind-utils wireguard-tools zsh tmux net-tools
RUN mkdir -p /root/.config/pueue
COPY files/pueue.yml /root/.config/pueue/pueue.yml
COPY --from=fedora-binaries /pueue /bin/pueue
COPY --from=fedora-binaries /pueued /bin/pueued
RUN chmod 0700 /bin/pueue /bin/pueued