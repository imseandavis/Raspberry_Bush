#!/bin/sh

# Install Docker
echo Installing Docker...
curl -sSL get.docker.com | sh && \
sudo usermod -aG docker pi

# Add Repo List
echo Adding Kubernetes Repos...
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null

#Install & Upgrade All Packages
echo Updating and Upgrading Packages...
sudo apt update -qqy && \
sudo apt upgrade -qqy

# Install KubeADM
echo Installing KubeADM...
sudo apt install -qqy kubeadm

#Build Node
 if [ -f "master" ]
   then 
     # Init KubeAdm, Set Token To Not Expire, and Use Flannel Pod Network For Add On
     echo Init KubeAdm, Set Token To Not Expire, and Use Flannel Pod Network For Add On...
     sudo kubeadm init --token-ttl=0 --pod-network-cidr=10.244.0.0/16

     # Make Kube Cluster Available
     echo Make Kube Cluster Available...
     echo 'mkdir -p $HOME/.kube' | sh
     echo 'sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config' | sh
     echo 'sudo chown $(id -u):$(id -g) $HOME/.kube/config' | sh

     # Install and Configure Network
     echo Installing Kubernetes Network...
     sudo sysctl net.bridge.bridge-nf-call-iptables=1 > /dev/null
     kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

     # Install WebUI Dashboard (Specific For Kub v1.16.x)
     echo Installing and Configuring WebUI Dashboard...
     kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta5/aio/deploy/recommended.yaml

     # Verify Master Node Is Up & Ready
     echo Verify Kubernetes Master Node Is Up and Ready...
     until kubectl get nodes | grep -E "Ready" -C 120; do sleep 5 | echo "Waiting For Node To Be Ready..."; done

     # Download Master Node Post Install Tasks
     echo Downloading Post Install Task Script...
     curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/Builds/k8s/master_post_install_tasks.sh -o post_install_tasks.sh

 elif [ -f "worker" ]
   then
     # Init Variables
     echo Configuring Kube Worker Node....
     echo
     echo You will need your Kubernetes Master Host IP and Login Information...
     echo
     echo Enter Kubernetes Master Host IP Address:
     read KubeMasterHostIP

     # Retrieve Token and Hash From Master Node
     echo Retrieving Token and Hash...
     KubeMasterToken=$(sudo ssh pi@$KubeMasterHostIP kubeadm token list | awk 'NR==2{print $1}')
     KubeMasterHash=$(sudo ssh pi@$KubeMasterHostIP "openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'")

     # Join Kubernetes Cluster
     echo Joining Worker Node To Master Host $KubMasterHostIP...
     sudo kubeadm join $KubeMasterHostIP:6443 --token $KubeMasterToken --discovery-token-ca-cert-hash sha256:$KubeMasterHash

     # Verify All Nodes Are Up & Ready
     echo Verify All Kubernetes Nodes Are Up and Ready...
     # Check Master Node
     until sudo ssh pi@$KubeMasterHostIP kubectl get nodes | awk 'NR==2{print $2}' | grep -E "Ready" -C 120; do sleep 5 | echo "Waiting For Node To Be Ready..."; done
     # Check Worker 1 Node
     until sudo ssh pi@$KubeMasterHostIP kubectl get nodes | awk 'NR==3{print $2}' | grep -E "Ready" -C 120; do sleep 5 | echo "Waiting For Node To Be Ready..."; done

     # Download Slave Node Post Install Tasks
     echo Downloading Post Install Tasks Script...
     curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/Builds/k8s/worker_post_install_tasks.sh -o post_install_tasks.sh

 else echo "No Build Flag Found, Aborting Build!";
 fi

# Housekeeping
echo Doing A Little Housekeeping....
rm -f build_kube_node.sh

# Reboot
echo Rebooting in 10 seconds...
sleep 10
sudo reboot now
