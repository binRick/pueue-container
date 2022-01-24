FROM fedora:35 as iodine-builder
RUN dnf -y install gcc make git zlib-devel
ADD files/iodine-0.7.0.tar.gz /
WORKDIR /iodine-0.7.0
RUN make
RUN ls /iodine-0.7.0/bin/iodine
RUN ls /iodine-0.7.0/bin/iodined
RUN cp /iodine-0.7.0/bin/iodine /iodine-0.7.0/bin/iodined /


FROM fedora:35 as fedora-iodine
RUN dnf -y install net-tools zsh tmux bash
COPY --from=iodine-builder /iodine /bin/iodine
COPY --from=iodine-builder /iodined /bin/iodined
COPY iodined-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
