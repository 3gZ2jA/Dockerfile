FROM alpine:edge

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk update && apk add dnscrypt-proxy dnscrypt-proxy-openrc tzdata && \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    rm -rf /var/cache/apk/* && rm -rf /tmp/*
# Add startup script

CMD ["/usr/bin/dnscrypt-proxy","-config","/etc/dnscrypt-proxy/dnscrypt-proxy.toml"]
