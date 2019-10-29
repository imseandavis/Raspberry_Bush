#!/bin/sh

# Enable Cluster For User After Docker Group Change
echo Make Kube Cluster Available To Current User...
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Check Pod Network
kubectl get pods --all-namespaces

# Check Cluster Nodes
kubectl get nodes

# Cleanup Remaining Files
rm -f post_install_tasks.sh
