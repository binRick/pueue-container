FROM docker.io/fedora:35 as fedora-ttyd-build
RUN dnf -y install cmake make gcc automake autoconf
ADD files/ttyd-1.6.3.tar.gz /
WORKDIR /ttyd-1.6.3
RUN dnf -y install zlib-devel
RUN dnf -y install libuv-devel
RUN dnf -y install libwebsockets-devel
RUN dnf -y install openssl openssl-devel
RUN dnf -y install json-c-devel json-parser-devel jsoncpp-devel libfastjson-devel

RUN cmake . && make -j
RUN cp ttyd /usr/bin/ttyd
COPY files/t.sh /t.sh
RUN chmod 0700 /t.sh
ENTRYPOINT /t.sh



FROM docker.io/fedora:35 as fedora-ttyd
RUN dnf -y install zsh bash fish libwebsockets libuv zlib zlib-devel libuv-devel libwebsockets-devel openssl openssl-devel json-c-devel json-parser-devel jsoncpp-devel libfastjson-devel
COPY --from=fedora-ttyd-build /usr/bin/ttyd /usr/bin/ttyd
