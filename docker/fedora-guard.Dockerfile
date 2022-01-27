FROM docker.io/fedora:35 as fedora-guard-builder

RUN dnf -y install git go gcc automake autoconf
RUN git clone https://github.com/binRick/guard /usr/src/guard && cd /usr/src/guard && make && cp guard /

FROM docker.io/fedora:35 as fedora-guard
RUN dnf -y install bash zsh wireguard-tools iptables iputils
COPY --from=fedora-guard-builder /guard /usr/bin/guard
RUN chmod 0700 /usr/bin/guard
RUN mkdir -p /etc/wireguard
RUN dnf -y install iproute net-tools




RUN dnf -y install bash systemd
RUN dnf clean all
RUN  (cd /lib/systemd/system/sysinit.target.wants/ ; for i in * ; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i ; done) ; \
  rm -f /lib/systemd/system/multi-user.target.wants/* ;\
  rm -f /etc/systemd/system/*.wants/* ;\
  rm -f /lib/systemd/system/local-fs.target.wants/* ; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev* ; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl* ; \
  rm -f /lib/systemd/system/basic.target.wants/* ;\
  rm -f /lib/systemd/system/anaconda.target.wants/*

RUN dnf -y install iputils iproute socat zsh bind-utils openssh-clients openssh-server procps-ng

VOLUME [ "/sys/fs/cgroup", "/tmp", "/run" ]

#RUN ln -sf /usr/lib/systemd/system/dbus-broker.service /etc/systemd/system/dbus.service
#CMD ["/usr/lib/systemd/systemd","--system"]

