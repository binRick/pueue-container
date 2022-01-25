FROM docker.io/fedora:35 as fedora-guard-builder

RUN dnf -y install git go gcc automake autoconf
RUN git clone https://github.com/binRick/guard /usr/src/guard && cd /usr/src/guard && make && cp guard /

FROM docker.io/fedora:35 as fedora-guard
COPY --from=fedora-guard-builder /guard /usr/bin/guard
RUN chmod 0700 /usr/bin/guard


