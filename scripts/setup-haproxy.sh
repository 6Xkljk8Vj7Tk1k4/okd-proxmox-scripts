#!/bin/bash

IP_BOOTSTRAP=10.10.20.225
IP_MASTER0=10.10.20.226
IP_MASTER1=10.10.20.227
IP_MASTER2=10.10.20.228

cp extras/haproxy.cfg.ORIG extras/haproxy.cfg

sed -Ezi "s/IP_BOOTSTRAP/$IP_BOOTSTRAP/g" extras/haproxy.cfg
sed -Ezi "s/IP_MASTER0/$IP_MASTER0/g" extras/haproxy.cfg
sed -Ezi "s/IP_MASTER1/$IP_MASTER1/g" extras/haproxy.cfg
sed -Ezi "s/IP_MASTER2/$IP_MASTER2/g" extras/haproxy.cfg

./scripts/create-haproxy.sh