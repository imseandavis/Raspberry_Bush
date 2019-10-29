#!/bin/sh

# Update Kube Admin Config To User Home
echo Make Kube Cluster Available To Current User...
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Download Demo Scripts
echo Downloading Demo Scripts...
curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/Builds/k8s/demo_deploy.sh -o demo_deploy.sh

# Cleanup Remaining Files
rm -f post_install_tasks.sh
