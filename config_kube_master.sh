#!/bin/sh

# Update Kub Config
sudo kubeadm init # --config kubeadm_conf.yaml

# Start Kub Cluster
mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Verify Master Is Up
kubectl get nodes

# Housekeeping
rm -f config_kube_master.sh
