FROM alpine:3.14 as alpine-iodine-builder
ADD files/iodine-0.7.0.tar.gz /
WORKDIR /iodine-0.7.0
RUN apk add zlib-dev automake gcc autoconf make libgsf-dev dev86 libc-dev musl-dev
RUN make -j
RUN cp bin/iodine /iodine
RUN cp bin/iodined /iodined
RUN chmod +x /iodine /iodined
RUN chown root:root /iodine /iodined


FROM alpine:3.14 as alpine-iodine
COPY --from=alpine-iodine-builder /iodine /usr/bin/iodine
COPY --from=alpine-iodine-builder /iodined /usr/bin/iodined
