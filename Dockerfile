FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    curl \
    wget \
    unzip \
    procps \
    ca-certificates \
    tzdata && \
    rm -rf /var/lib/apt/lists/*

COPY install.sh /app/install.sh

RUN chmod +x /app/install.sh && \
    /app/install.sh

RUN mkdir -p /etc/xray
RUN mkdir -p /var/log/xray

COPY config.json /etc/xray/config.json

COPY startup.sh /app/startup.sh
COPY healthcheck.sh /app/healthcheck.sh

RUN chmod +x /app/startup.sh && \
    chmod +x /app/healthcheck.sh

EXPOSE 443

HEALTHCHECK --interval=60s --timeout=10s --retries=3 \
CMD /app/healthcheck.sh || exit 1

CMD ["/app/startup.sh"]
