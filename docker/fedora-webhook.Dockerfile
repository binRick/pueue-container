FROM docker.io/fedora:35 as fedora-webhook
COPY files/webhookserver-linux-amd64-v0.1.4 /usr/bin/webhookserver
RUN chmod 0700 /usr/bin/webhookserver
RUN chown root:root /usr/bin/webhookserver
RUN ls /usr/bin/webhookserver
RUN mkdir -p /root/.local/share/pueue
RUN mkdir -p /root/.config
COPY files/webhook_server.yml /root/.config/webhook_server.yml

