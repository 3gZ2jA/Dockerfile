#! /bin/sh
#
# entrypoint.sh

set -e

[[ "$DEBUG" == "true" ]] && set -x

getent group qbittorrent >/dev/null || addgroup -g ${GID} qbittorrent
getent passwd qbittorrent >/dev/null || adduser -h /etc/qBittorrent -s /bin/sh -G qbittorrent -D -u ${UID} qbittorrent

mkdir -p /etc/qBittorrent/

[[ ! -f /etc/qBittorrent/qBittorrent.conf ]] && cp /etc/qBittorrent.conf /etc/qBittorrent/

sed -i "s|Connection\\\PortRangeMin=.*|Connection\\\PortRangeMin=${PEER_PORT}|i" /etc/qBittorrent/qBittorrent.conf

chown -R qbittorrent:qbittorrent /etc/qBittorrent

exec su-exec qbittorrent:qbittorrent "$@"
