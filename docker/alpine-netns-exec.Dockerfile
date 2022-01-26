FROM alpine:3.14 as alpine-netns-exec-build

RUN apk add make linux-headers git gcc zlib-dev automake gcc autoconf make libgsf-dev dev86 libc-dev musl-dev
RUN git clone https://github.com/binRick/netns-exec /usr/src/netns-exec
WORKDIR /usr/src/netns-exec
RUN git submodule update --init
RUN make -j
RUN cp netns-exec netns-exec-dbus /

FROM alpine:3.14 as alpine-netns-exec
COPY --from=alpine-netns-exec-build /netns-exec /netns-exec
COPY --from=alpine-netns-exec-build /netns-exec-dbus /netns-exec-dbus
