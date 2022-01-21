FROM docker.io/fedora:35 as fedora-gottyd

ADD https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz /
RUN tar zxvf /gotty_2.0.0-alpha.3_linux_amd64.tar.gz
RUN mv /gotty /usr/bin/gotty
RUN chmod 0700 /usr/bin/gotty
RUN unlink /gotty_2.0.0-alpha.3_linux_amd64.tar.gz


