#!/bin/bash -e

exec 2>stderr.log
exec 1>stdout.log

function show() {
  echo -e "\n> docker service ls"
  docker service ls
  echo -e "\n> docker service ps docker-swarm-shutdown-test"
  docker service ps docker-swarm-shutdown-test
  echo -e "\n> docker ps"
  docker ps
}

echo -e "\nBuilding"
date > marker
docker build -t docker-swarm-shutdown-test:1 .
date > marker
docker build -t docker-swarm-shutdown-test:2 .

echo -e "\nCreating"
docker service create \
  -d \
  --stop-grace-period 600s \
  --update-order stop-first \
  --mode replicated \
  --replicas 2 \
  --name docker-swarm-shutdown-test \
  docker-swarm-shutdown-test:1

echo -e "\n> sleep 5"
sleep 5

show

echo -e "\nUpdating"
docker service update \
  -d \
  --image docker-swarm-shutdown-test:2 \
  docker-swarm-shutdown-test

for i in $(seq 1  10); do
  echo -e "\n> sleep 60"
  sleep 60
  show
done

docker service logs docker-swarm-shutdown-test > container.log

# Cleanup
docker service rm docker-swarm-shutdown-test

