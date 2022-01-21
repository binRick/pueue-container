FROM docker.io/fedora:35 as fedora-webhook
COPY files/webhookserver-linux-amd64-v0.1.4 /webhookserver
RUN chmod 0700 /webhookserver
RUN chown root:root /webhookserver
RUN ls /webhookserver
