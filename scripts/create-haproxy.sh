#!/bin/bash

ID=29998
TEMPLATE_STORAGE=local
TEMPLATE_NAME=ubuntu-22.04-standard_22.04-1_amd64.tar.zst
BRIDGE=vmbr0
VLAN=20
STORAGE=zfs-intel
PATH=$(pwd)

/usr/bin/pveam download $TEMPLATE_STORAGE $TEMPLATE_NAME

/usr/sbin/pct create $ID $TEMPLATE_STORAGE:vztmpl/$TEMPLATE_NAME --cores 1 --hostname okd-haproxy --net0 name=eth0,bridge=$BRIDGE,ip=dhcp,tag=$VLAN,type=veth --ostype ubuntu --storage $STORAGE
/usr/sbin/pct start $ID

/usr/sbin/pct exec $ID -- bash -c 'apt-get update'
/usr/sbin/pct exec $ID -- bash -c 'apt-get install --no-install-recommends software-properties-common'
/usr/sbin/pct exec $ID -- bash -c 'add-apt-repository ppa:vbernat/haproxy-2.8'
/usr/sbin/pct exec $ID -- bash -c 'apt-get update | apt-get -y install haproxy=2.8.\*'
/usr/sbin/pct push $ID $PATH/extras/haproxy.cfg /etc/haproxy/haproxy.cfg
/usr/sbin/pct exec $ID -- bash -c 'systemctl restart haproxy'
