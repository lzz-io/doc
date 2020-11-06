#!/bin/bash

## port 7000--7005
docker run -d --network host -e "IP=0.0.0.0" grokzen/redis-cluster:latest