#!/bin/sh

#Build Node
 if [ -f "master" ]
   then 
     # Install k3s
     echo 
     echo "Installing k3s...";
     curl -sfL https://get.k3s.io | sh -

     # Check k3s Status
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
     KubeMasterJoinKey=$(sudo ssh -o "StrictHostKeyChecking no" pi@$KubeMasterHostIP sudo cat /var/lib/rancher/k3s/server/node-token)
     export K3S_URL=$KubeMasterURL
     export K3S_TOKEN=$KubeMasterJoinKey
     
     # Install k3s
     echo
     echo "Installing k3s and joining to master..." 
     curl -sfL https://get.k3s.io | sh -
     echo
     echo "Joining To Master..."
     sudo k3s agent --server $KubeMasterURL --token $KubeMasterJoinKey
     
     #Checking k3s Node Status's On Server
     echo 
     echo Sleeping for 5 Seconds, Then Checking The New Node Status
     sudo ssh pi@$KubeMasterHostIP sleep 5; sudo kubectl get node -o wide

 else echo "No Build Flag Found, Aborting Build!";
 fi

# Housekeeping
#echo Doing A Little Housekeeping....
#rm -f build_kube_node.sh

# Reboot
#echo Rebooting in 10 seconds...
#sleep 10
#sudo reboot now
