FROM alpine:edge

MAINTAINER docker@chabs.name

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk upgrade && apk add --no-cache amule git tzdata && \
    ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone && \
    cd /usr/share/amule/webserver \
    && git clone https://github.com/MatteoRagni/AmuleWebUI-Reloaded \
    && rm -rf AmuleWebUI-Reloaded/.git AmuleWebUI-Reloaded/doc-images \
	&& apk del git \
    && rm -rf /var/cache/apk/* && rm -rf /opt && rm -rf /tmp/*

VOLUME ["/etc/amule"]

EXPOSE 4711/tcp 4712/tcp 4672/udp 4665/udp 4662/tcp 4661/tcp
 
CMD ["/usr/bin/amuled","-c","/etc/amule"]