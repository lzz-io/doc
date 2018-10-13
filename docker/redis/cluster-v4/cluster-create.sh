#!/bin/bash
set -e

HOSTS=""
for i in $( seq 1 6 ); do
	host=redis$i
	ip=`ping $host -s1 -c1 | grep $host | head -n1 | cut -d'(' -f2 | cut -d')' -f1`
	# HOSTS="$HOSTS 127.0.0.1:$PORT"
	HOSTS="$HOSTS $ip:6379"
done
echo $HOSTS
echo yes | ruby /usr/local/bin/redis-trib.rb create --replicas 1 $HOSTS
