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
RUN dnf -y install ansible

COPY files/ssh_config /etc/ssh/ssh_config
RUN chmod 644 /etc/ssh/ssh_config
RUN sh -c 'dnf -y remove ansible*'
RUN dnf -y install python3-pip
RUN pip3 install ansible -U
RUN ansible --version
RUN dnf -y install nagios-plugins-tcp nagios-plugins-ssh nagios-plugins-ping nagios-plugins-http nagios-plugins-fping nagios-plugins-dns nagios-plugins-dig nagios-plugins-by_ssh

RUN dnf -y remove audit

RUN dnf -y install golang

RUN env GO111MODULE=on go install github.com/DarthSim/hivemind@latest
RUN mv /root/go/bin/hivemind /usr/bin/hivemind
COPY files/Procfile /.Procfile
COPY files/hivemind.env /etc/profile.d/hivemind.sh

COPY files/ttyd /usr/bin/ttyd
RUN go get github.com/Depau/ttyc/cmd/ttyc
RUN mv /root/go/bin/ttyc /usr/bin/ttyc
