#!/bin/sh

# Install k3s
curl -sfL https://get.k3s.io | sh -

# Check Status
sudo systemctl status k3s

# Get Join Key
sudo cat /var/lib/rancher/k3s/server/node-token


# Join A Worker
#export K3S_URL="https://192.168.0.32:6443"
#export K3S_TOKEN="K1089729d4ab5e51a44b1871768c7c04ad80bc6319d7bef5d94c7caaf9b0bd29efc::node:1fcdc14840494f3ebdcad635c7b7a9b7"
#curl -sfL https://get.k3s.io | sh -

# Housekeeping
#echo Doing A Little Housekeeping....
#rm -f build_kube_node.sh

# Reboot
#echo Rebooting in 10 seconds...
#sleep 10
#sudo reboot now
