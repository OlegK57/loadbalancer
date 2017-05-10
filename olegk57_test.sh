#!/bin/bash

docker-machine create --driver virtualbox --virtualbox-cpu-count "2" default || exit 255

eval "$(docker-machine env default)"

for ((i=1;i<=6;i++))
do
	docker run -d -p :80 olegk57/bolek
done

for ((i=1;i<=8;i++))
do
	docker run -d -p :80 olegk57/lolek
done

for ((i=1;i<=3;i++))
do
	docker run -d -p :80 olegk57/bolek
done

for ((i=1;i<=4;i++))
do
	docker run -d -p :80 olegk57/lolek
done

for ((i=1;i<=6;i++))
do
	docker run -d -p :80 olegk57/bolek
done

docker run -d --name=consul --net=host -p 8500:8500 gliderlabs/consul-server -bootstrap -advertise=127.0.0.1

docker run -d --name=registrator --net=host --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest consul://localhost:8500

docker run -d --name=loadbalancer --net=host -p 80:80 olegk57/loadbalancer -consul-addr=localhost:8500

docker run -d --name myjenkins -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock --group-add=$(stat -c %g /var/run/docker.sock) olegk57/ci:latest

eval "$(docker-machine env -u)"

IP=$(docker-machine ip default)

echo
echo "Tests URLs"
echo "========================="
echo

echo "http://$IP:/lolek/index.html"
echo "http://$IP:/lolek/version.html"
echo
echo "http://$IP:/bolek/index.html"
echo "http://$IP:/bolek/version.html"
echo

echo "Consul server"
echo "http://$IP:8500/ui"
echo

echo "CI (Jenkins) server"
echo "http://$IP:8080/"
