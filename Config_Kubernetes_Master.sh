#!/bin/sh

# Download The Kub Config File From GitHub
curl -sSL github.com/imseandavis/Raspberry_Bush/new/master/kubadmin_conf.yaml

# Update Kub Config
kubeadm init --config kubeadm_conf.yaml

# Start Kub Cluster
mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Verify Master Is Up
kubectl get nodes
