#!/bin/bash

SUBNET=`ip -4 addr show|grep global|sed 's/[ \t]*inet[ \t]*//'|cut -d. -f1-3`

sed -i -e "s/ADDR/$SUBNET/g" /usr/local/etc/haproxy/haproxy.cfg

./docker-entrypoint.sh
