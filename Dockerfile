FROM haproxy:1.7

MAINTAINER OlegK57
LABEL maintainer "OlegK57@gmail.com"

ENV CONSUL_TEMPLATE_VERSION=0.10.0

# Download consul-template
RUN ( apt-get update && apt-get install -y wget && wget --no-check-certificate https://github.com/hashicorp/consul-template/releases/download/v${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tar.gz -O /tmp/consul_template.tar.gz && gunzip /tmp/consul_template.tar.gz && cd /tmp && tar xf /tmp/consul_template.tar && cd /tmp/consul-template* && mv consul-template /usr/bin && rm -rf /tmp/* )

COPY files/haproxy.json /tmp/haproxy.json
COPY files/haproxy.ctmpl /tmp/haproxy.ctmpl

ENTRYPOINT ["consul-template", "-config=/tmp/haproxy.json"]
