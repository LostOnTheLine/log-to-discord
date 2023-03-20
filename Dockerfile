FROM alpine:latest

RUN addgroup -g 1000 docker && \
    adduser -u 1000 -G docker -s /bin/sh -D docker && \
    apk add --no-cache bash curl

WORKDIR /app

COPY send_to_discord.sh .
COPY healthcheck.sh .

RUN chmod +x send_to_discord.sh healthcheck.sh

ENV DISCORD_WEBHOOK="https://discord.com/api/webhooks/your-webhook-url"
ENV LOG_FILE="/var/log/sample.log"

HEALTHCHECK --interval=10s --start-period=30s --retries=3 --timeout=5s \
  CMD /app/healthcheck.sh


USER docker

CMD ["/bin/bash", "send_to_discord.sh"]
