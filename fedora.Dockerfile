FROM fedora:latest as common-pkgs
RUN dnf clean all
RUN dnf -y install bash zsh sudo

FROM common-pkgs as base-pkgs
RUN dnf -y install procps-ng iputils iproute coreutils \
                   httpie socat bind-utils wireguard-tools  tmux zsh bash



FROM base-pkgs as binaries
ADD https://github.com/Nukesor/webhook-server/releases/download/v0.1.4/webhookserver-linux-amd64 /webhookserver
ADD https://github.com/Nukesor/pueue/releases/download/v1.0.6/pueue-linux-x86_64 /pueue
ADD https://github.com/Nukesor/pueue/releases/download/v1.0.6/pueued-linux-x86_64 /pueued
ADD https://github.com/Nukesor/pueue/releases/download/v1.0.6/systemd.pueued.service /etc/systemd/system/pueued.service
RUN chmod 700 /pueue /pueued /webhookserver






FROM fedora:latest as fedora-pueue-container
RUN mkdir -p /root/.config/pueue
COPY --from=binaries /pueue /bin/.
COPY --from=binaries /pueued /bin/.
COPY --from=binaries /webhookserver /bin/.
#COPY --from=iodine-builder /iodine /bin/.
#COPY --from=iodine-builder /iodined /bin/.
#COPY --from=builder /key.pem /root/.config/pueue/key.pem
#COPY --from=builder /cert.pem /root/.config/pueue/cert.pem


RUN echo 'pueued -c ~/.config/pueue/pueue.yml --verbose' > /pueued.sh
RUN echo 'webhookserver' > /webhookserver.sh
RUN chmod 700 /pueued.sh /webhookserver.sh
#RUN chmod 600 /root/.config/pueue/key.pem /root/.config/pueue/key.pem


RUN dnf -y install procps-ng bash httpie iputils iproute socat zsh bind-utils wireguard-tools


COPY files/pueue.yml /root/.config/pueue/pueue.yml
COPY files/webhook_server.yml /root/.config/webhook_server.yml
RUN chmod 600 /root/.config/pueue/pueue.yml /root/.config/webhook_server.yml

ENV container=docker

RUN dnf -y install systemd && dnf clean all && \
  (cd /lib/systemd/system/sysinit.target.wants/ ; for i in * ; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i ; done) ; \
  rm -f /lib/systemd/system/multi-user.target.wants/* ;\
  rm -f /etc/systemd/system/*.wants/* ;\
  rm -f /lib/systemd/system/local-fs.target.wants/* ; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev* ; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl* ; \
  rm -f /lib/systemd/system/basic.target.wants/* ;\
  rm -f /lib/systemd/system/anaconda.target.wants/*

COPY files/pueued.service /etc/systemd/system/.
RUN chmod 0600 /etc/systemd/system/pueued.service

VOLUME ["/sys/fs/cgroup"]
CMD "/sbin/init"

COPY files/iodined.service /etc/systemd/system/.
RUN chmod 0600 /etc/systemd/system/iodined.service

RUN dnf -y install zsh tmux
RUN dnf -y install net-tools















