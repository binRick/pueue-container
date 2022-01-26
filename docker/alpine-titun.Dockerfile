FROM alpine:3.14 as alpine-titun-builder

RUN apk add cargo git
RUN git clone https://github.com/sopium/titun /titun
WORKDIR /titun
RUN apk add file gcc cmake automake make
RUN apk add linux-headers
RUN cargo build --release
