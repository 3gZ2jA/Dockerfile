FROM alpine:edge


LABEL maintainer="zgist" 

ENV PEER_PORT=6881 \
    WEB_PORT=8080 \
    UID=1000 \
    GID=1000

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --no-cache qbittorrent-nox su-exec && \
    cd / \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

COPY rootfs /

EXPOSE $PEER_PORT $PEER_PORT/udp $WEB_PORT

VOLUME /etc/qBittorrent

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD ["/usr/bin/qbittorrent-nox","--profile=/etc/qBittorrent/"]

