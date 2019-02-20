#!/bin/sh

# Update Kube Config
echo Init KubeAdm...
sudo kubeadm init # --config kubeadm_conf.yaml

# Start Kube Cluster
echo Start Kub Cluster...
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Verify Master Is Up
echo Verify Kubernetes Master Node Is Up...
kubectl get nodes

# Housekeeping
echo Do Some Housekeeping...
rm -f config_kube_master.sh
