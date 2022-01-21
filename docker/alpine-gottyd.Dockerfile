FROM alpine:3.14 as alpine-ttyd
ADD https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz /
RUN tar zxvf /gotty_2.0.0-alpha.3_linux_amd64.tar.gz
RUN chmod +x /gotty
RUN /gotty --help



