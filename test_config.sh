#!/bin/bash

CURRP=`pwd`
docker run -it --rm --name haproxy-syntax-check -v $CURRP/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro haproxy:1.7 haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg
