FROM alpine:3.14 as alpine-titun-builder
RUN apk add cargo git file gcc cmake automake make linux-headers
RUN git clone https://github.com/sopium/titun /usr/src/titun
WORKDIR /usr/src/titun
RUN cargo build --release
RUN cp target/release/titun /


FROM alpine:3.14 AS alpine-titun
COPY --from=alpine-titun-builder /titun /titun
