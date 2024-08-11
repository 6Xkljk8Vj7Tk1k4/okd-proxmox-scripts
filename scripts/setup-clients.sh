#!/bin/bash
#Go to https://github.com/openshift/okd/releases/, replace version

VERSION=4.15.0-0.okd-2024-03-10-010116
wget https://github.com/openshift/okd/releases/download/$VERSION/openshift-client-linux-$VERSION.tar.gz
wget https://github.com/openshift/okd/releases/download/$VERSION/openshift-install-linux-$VERSION.tar.gz

tar xvf openshift-client-linux-$VERSION.tar.gz
tar xvf openshift-install-linux-$VERSION.tar.gz

rm openshift-client-linux-$VERSION.tar.gz
rm openshift-install-linux-$VERSION.tar.gz
