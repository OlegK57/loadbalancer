FROM haproxy:1.7

MAINTAINER OlegK57
LABEL maintainer "OlegK57@gmail.com"

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
