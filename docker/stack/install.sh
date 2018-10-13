#!/bin/bash


docker network create -d=overlay --subnet=10.10.0.0/16 --attachable mynet

docker stack deploy -c paas.yml paas

