FROM alpine:3.14 as alpine-titun-builder

RUN apk add cargo git
RUN git clone https://github.com/sopium/titun /titun
WORKDIR /titun
RUN apk add file
RUN cargo build --release
