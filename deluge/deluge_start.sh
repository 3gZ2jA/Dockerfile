#!/bin/sh

/usr/bin/deluge-web -c /etc/deluge --loglevel=info
/usr/bin/deluged -c /etc/deluge -d --loglevel=info -l /etc/deluge/deluged.log
