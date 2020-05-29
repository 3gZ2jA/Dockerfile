FROM alpine:edge

COPY ./deluge_start.sh /deluge_start.sh

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
  apk update && \
  apk add deluge && \
adduser -u 1001 -S media -G users && \
  mkdir /etc/deluge  && \
  chown -R media:users /etc/deluge  && \
  chmod +x /deluge_start.sh && \
  chown media:users /deluge_start.sh

#two processes running kind of goes against the docker mentality
#would prefer if i could split the daemon and the web front-end but this relies on the app
#For now, a simple shell script works fine

EXPOSE 53160 8112 58846
EXPOSE 53160/udp

USER media

VOLUME ["/etc/deluge"]

CMD ["/deluge_start.sh"]
