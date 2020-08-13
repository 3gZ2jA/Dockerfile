FROM alpine

ARG VERSION

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

LABEL maintainer="zgist" \
        org.label-schema.name="Transmission" \
        org.label-schema.version=$VERSION

ENV UID=1000 \
    GID=1000 \
    RPC_PORT=9091 \
    PEER_PORT=51413 \
    USERNAME=username \
    PASSWORD=

# Let's roll
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    set -xe && \
    apk add --no-cache tzdata curl su-exec shadow tar transmission-daemon && \
    ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone && \
    cd /tmp && \
    curl -sSL https://github.com/ronggang/transmission-web-control/archive/v1.6.0-beta2.tar.gz | \
    tar xz --strip 1 && \
    cp /usr/share/transmission/web/index.html /usr/share/transmission/web/index.original.html && \
    cp -rf /tmp/src/* /usr/share/transmission/web/ && \
    apk del tar curl && \
    rm -rf /var/cache/apk/* && rm -rf /tmp/*

# COPY rootfs /

VOLUME ["/var/lib/transmission-daemon/"]

EXPOSE $RPC_PORT $PEER_PORT $PEER_PORT/UDP

# ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD /usr/bin/transmission-daemon \
        --foreground \
        --config-dir /var/lib/transmission-daemon/.config/transmission-daemon/ \
        --port $RPC_PORT \
        --peerport $PEER_PORT \
        --username $USERNAME \
        --password ${PASSWORD:-$(hostname)}
