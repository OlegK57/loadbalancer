FROM haproxy:1.7

MAINTAINER OlegK57
LABEL maintainer "OlegK57@gmail.com"

ENV CONSUL_TEMPLATE_VERSION=0.18.1

RUN apt-get update && apt-get install -y wget 

# Download consul-template
RUN ( wget --no-check-certificate https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tgz -O /tmp/consul_template.tgz && cd /tmp && tar xzf /tmp/consul_template.tgz && mv consul-template /usr/bin && rm -rf /tmp/* )

COPY files/haproxy.json /tmp/haproxy.json
COPY files/haproxy.ctmpl /tmp/haproxy.ctmpl

ENTRYPOINT ["consul-template", "-config=/tmp/haproxy.json"]
