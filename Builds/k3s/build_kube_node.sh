#!/bin/sh

#Build Node
 if [ -f "master" ]
   then 
     # Install k3s
     echo 
     echo "Installing k3s...";
     curl -sfL https://get.k3s.io | sh -

     # Check k3s Status
     echo 
     sudo systemctl status k3s

     # Get Master Node Join Key
     echo 
     echo "Master Join String - Keep This Somewhere Safe";
     sudo cat /var/lib/rancher/k3s/server/node-token

 elif [ -f "worker" ]
   then
     # Build Exports To Join A Worker
     echo Configuring Kube Worker Node....
     echo 
     echo You will need your Kubernetes Master Host IP...
     echo
     echo Enter Kubernetes Master Host IP Address:
     read KubeMasterHostIP
     echo
     echo Retrieving Kubernetes Master Join Token
     KubeMasterURL="https://$KubeMasterHostIP:6443"
     KubeMasterJoinKey="$(sudo ssh -o "StrictHostKeyChecking no" pi@$KubeMasterHostIP sudo cat /var/lib/rancher/k3s/server/node-token)"
     export K3S_URL="$KubeMasterURL"
     export K3S_TOKEN="$KubeMasterJoinKey"
     
     # Install k3s
     echo
     echo "Installing k3s and joining to master..." 
     curl -sfL https://get.k3s.io | sh -
     
     # Check k3s Status
     echo 
     echo "Checking Agent Status..."
     sudo systemctl status k3s-agent
     
     #Checking k3s Node Status's On Server
     echo 
     echo Checking The New Node Status...
     echo
     sudo ssh pi@$KubeMasterHostIP sudo kubectl get node -o wide

 else echo "No Build Flag Found, Aborting Build!";
 fi

# Housekeeping
#echo Doing A Little Housekeeping....
rm -f build_kube_node.sh

# Reboot
echo Rebooting in 5 seconds...
sleep 5
sudo reboot now
