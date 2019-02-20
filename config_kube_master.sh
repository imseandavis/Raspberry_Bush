#!/bin/sh

# Init KubeAdm
echo Init KubeAdm...
sudo kubeadm init

# Start Kube Cluster
echo Start Kube Cluster...
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Verify Kubernetes Master Node Is Up and Running
echo Verify Kubernetes Master Node Is Up and Running...
kubectl get nodes

# Housekeeping
echo Do Some Housekeeping...
rm -f config_kube.sh

echo Done!
