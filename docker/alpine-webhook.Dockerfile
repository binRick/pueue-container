FROM alpine:3.14 as alpine-webhook
RUN mkdir -p /root/.config
ADD files/webhookserver-linux-amd64-v0.1.4 /usr/bin/webhookserver
RUN chmod +x /usr/bin/webhookserver
RUN chown root:root /usr/bin/webhookserver
COPY files/webhook_server.yml /root/.config/webhook_server.yml
RUN chmod 600 /root/.config/webhook_server.yml
RUN chown root:root /root/.config/webhook_server.yml
