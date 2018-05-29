FROM alpine:3.7

MAINTAINER Harish Anchu <harishanchu@gmail.com>

RUN apk add --update --no-cache ca-certificates \
    && apk add --update --no-cache wget

ENV KSONNET_VERSION="0.10.2"
ENV KSONNET_SHA256="2f15f6fbecf6f597cf0aa8b623c1e49d589b7d409b73004b19b356fbcb6f096f"
ENV KSONNET_URL="https://github.com/ksonnet/ksonnet/releases/download/v${KSONNET_VERSION}/ks_${KSONNET_VERSION}_linux_amd64.tar.gz"

RUN mkdir -p /opt/ksonnet

RUN set -e; \
    echo "downloading $KSONNET_URL" \
    && wget -q $KSONNET_URL -O /opt/ksonnet.tgz \
    && echo "$KSONNET_SHA256  /opt/ksonnet.tgz" | sha256sum -c - \
    && tar -C /opt/ksonnet --extract --file /opt/ksonnet.tgz --strip-components=1 \
    && chmod +x /opt/ksonnet/ks \
    && rm /opt/ksonnet.tgz
