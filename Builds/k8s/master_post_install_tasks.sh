#!/bin/sh

# Download Demo Scripts
echo Downloading Demo Scripts...
curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/Builds/k8s/demo_deploy.sh -o demo_deploy.sh
echo
echo You must run the three commands below before the cluster will be working and ready.
echo
echo mkdir -p $HOME/.kube
echo sudo cp -i -f /etc/kubernetes/admin.conf $HOME/.kube/config
echo sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Cleanup Remaining Files
rm -f post_install_tasks.sh
