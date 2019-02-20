#!/bin/sh

# Update Kube Config
echo Join Kube Slave Node To Master...
sudo kubeadm join --token TOKEN 192.168.1.100:6443 --discovery-token-ca-cert-hash HASH

#Verify Master Is Up
echo Verify Kubernetes Node Has Been Added Successful...
kubectl get nodes

# Housekeeping
echo Do Some Housekeeping...
rm -f config_kube_slave.sh
