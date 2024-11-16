#!/bin/bash
#Replace the variables if you need

ID=29999
NAME=fcos-template
STORAGE=data
CPU=4
RAM=16384
NET_TYPE=virtio
BRIDGE=vmbr0
ADD_STORAGE=112G

/usr/sbin/qm create $ID --name $NAME --cpu cputype=x86-64-v2 --cores $CPU --memory $RAM --net0 $NET_TYPE,bridge=$BRIDGE
/usr/sbin/qm importdisk $ID fedora-coreos.qcow2 $STORAGE
/usr/sbin/qm set $ID --scsihw virtio-scsi-single --virtio0 $STORAGE:vm-$ID-disk-0
/usr/sbin/qm set $ID --boot c --bootdisk virtio0
/usr/sbin/qm resize $ID virtio0 +$ADD_STORAGE
/usr/sbin/qm template $ID
