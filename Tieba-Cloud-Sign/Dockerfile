
FROM alpine:latest

MAINTAINER zsnmwy <szlszl35622@gmail.com>



RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
	apk update && \
	apk upgrade -a || apk fix && \
	apk add ca-certificates curl bash ncurses shadow su-exec s6 && \
	apk add php7 php7-fpm  php7-json php7-curl php7-gd php7-mysqli php7-mbstring  php7-zip    \
	php7-fileinfo git && \
	curl -sSL -o- "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=off" | tar -xvz -C /tmp && \
	cp -r /tmp/caddy /usr/sbin/caddy && \
	wget https://mirrors.aliyun.com/composer/composer.phar && mv composer.phar /usr/bin && \
	ln -sf /usr/bin/php7 /usr/bin/php && \
  	rm -rf /srv/www && \
  	cd / && git clone https://github.com/MoeNetwork/Tieba-Cloud-Sign.git /srv/www && cd /srv/www &&\
  	groupadd -g 1000 caddy && \
  	useradd -u 1000 -d /srv/www -g caddy -s /bin/bash -M caddy && \
  	apk add mailcap && \
    apk del  git && \
    rm -rf /var/cache/apk/* /etc/php7/* /tmp/* && \
    rm -r /usr/share/man && \
    echo "* * * * * /usr/bin/php7 /srv/www/do.php" >> /etc/crontabs/root

COPY ./overlay ./overlay-amd64 /

ENV DB_HOST='127.0.0.1'\
    DB_USER='root'\
    DB_PASSWD=''\
    DB_NAME='tiebacloud' \
    CONIFG_PATH='/srv/www/config.php' \
    CSRF='true'

EXPOSE 8080

WORKDIR /srv/www

ENTRYPOINT sed -i ''"$(cat ${CONIFG_PATH} -n | grep "DB_HOST" | awk '{print $1}')"'c '"$(echo "define('DB_HOST','${DB_HOST}');")"'' ${CONIFG_PATH} && \
              sed -i ''"$(cat ${CONIFG_PATH} -n | grep "DB_USER" | awk '{print $1}')"'c '"$(echo "define('DB_USER','${DB_USER}');")"'' ${CONIFG_PATH} && \
               sed -i ''"$(cat ${CONIFG_PATH} -n | grep "DB_PASSWD" | awk '{print $1}')"'c '"$(echo "define('DB_PASSWD','${DB_PASSWD}');")"'' ${CONIFG_PATH} && \
              sed -i ''"$(cat ${CONIFG_PATH} -n | grep "DB_NAME" | awk '{print $1}')"'c '"$(echo "define('DB_NAME','${DB_NAME}');")"'' ${CONIFG_PATH} && \
              sed -i ''"$(cat ${CONIFG_PATH} -n | grep "ANTI_CSRF" | awk '{print $1}')"'c '"$(echo "define('ANTI_CSRF',"${CSRF}");")"'' ${CONIFG_PATH} && \
              cat ${CONIFG_PATH} && \
              crond && \
              /bin/s6-svscan /etc/s6