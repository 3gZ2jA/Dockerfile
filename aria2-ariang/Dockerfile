FROM alpine:latest

MAINTAINER colinwjd <wjdwjd@live.cn>

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk update && \
    apk add --no-cache --update aria2 darkhttpd tzdata && \
    ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone && \
	mkdir -p aria2/conf aria2/conf-temp aria2/downloads aria-ng && \
    wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.1.6/AriaNg-1.1.6.zip  && \
    unzip AriaNg-1.1.6.zip -d aria-ng && \
	rm -rf AriaNg-1.1.6.zip && rm -rf /var/cache/apk/* && rm -rf /tmp/*

COPY init.sh /aria2/init.sh
COPY conf-temp /aria2/conf-temp

WORKDIR /
VOLUME ["/aria2/conf", "/mnt/sdb3/aria2"]
EXPOSE 16800 80 8080

CMD ["/aria2/init.sh"]
