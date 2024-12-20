#!/bin/bash

ID=29998
TEMPLATE_STORAGE=local
TEMPLATE_NAME=debian-12-standard_12.7-1_amd64.tar.zst
BRIDGE=vmbr0
STORAGE=data
PATH=$(pwd)

/usr/bin/pveam download $TEMPLATE_STORAGE $TEMPLATE_NAME

/usr/sbin/pct create $ID $TEMPLATE_STORAGE:vztmpl/$TEMPLATE_NAME --cores 1 --hostname okd-haproxy --net0 name=eth0,bridge=$BRIDGE,ip=dhcp,type=veth --ostype debian --storage $STORAGE
/usr/sbin/pct start $ID

/usr/sbin/pct exec $ID -- bash -c 'apt-get update | apt-get -y install curl gnupg2'
/usr/sbin/pct exec $ID -- bash -c 'curl https://haproxy.debian.net/bernat.debian.org.gpg | apt-key add -'
/usr/sbin/pct exec $ID -- bash -c 'echo deb http://haproxy.debian.net bookworm-backports-2.8 main | tee /etc/apt/sources.list.d/haproxy.list'
/usr/sbin/pct exec $ID -- bash -c 'apt-get update | apt-get -y install haproxy=2.8.\*'
/usr/sbin/pct push $ID $PATH/extras/haproxy.cfg /etc/haproxy/haproxy.cfg
/usr/sbin/pct exec $ID -- bash -c 'systemctl restart haproxy'
