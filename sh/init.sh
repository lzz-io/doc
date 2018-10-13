#!/bin/bash

set -e

# echo -n "input hostname:"
# read NUM

# set hostname
# hostnamectl set-hostname c${NUM}
hostnamectl set-hostname c$1
echo hostname: `hostname`

# set ip
# sed -i "s/IPADDR=192.168.*/IPADDR=192.168.56.${NUM}/g" /etc/sysconfig/network-scripts/ifcfg-enp0s8
sed -i "s/IPADDR=192.168.*/IPADDR=192.168.56.$1/g" /etc/sysconfig/network-scripts/ifcfg-enp0s8
# systemctl restart network
ip a | grep enp0s8

