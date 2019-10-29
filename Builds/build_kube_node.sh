#!/bin/sh

# Install Docker
echo Installing Docker...
curl -sSL get.docker.com | sh && \
sudo usermod -aG docker pi

# Add Repo List
echo Adding Kubernetes Repos...
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null

#Install & Upgrade All Packages - Have To Use APT-GET Due To Some Kubernetes Nuances
echo Updating and Upgrading Packages...
sudo apt update -qqy && \
sudo apt upgrade -qqy

# Install KubeADM
echo Installing KubeADM...
sudo apt-get install -qqy kubeadm

#Download Config Files
echo "Pick A Role To Install: (M)aster Node or (S)lave Node"
while :
do
  read INPUT_STRING
  case $INPUT_STRING in
	M)
    echo Configuring Kube Master Node....
    
    # Init KubeAdm
    echo Init KubeAdm...
    sudo kubeadm init --token-ttl=0 --pod-network-cidr=10.244.0.0/16
            
    # TODO: Secure admin.conf / kube.conf
    
    # TODO: SAVE TOKEN TO FILE
        
    # Make Kube Cluster Available
    echo Make Kube Cluster Available...
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    
    #Install and Configure Network
    echo Installing Kubernetes Network...
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    sysctl net.bridge.bridge-nf-call-iptables=1
    
    # Optional: Install WebUI Dashboard (Specific For Kub v1.16.x)
    echo Installing and Configuring WebUI Dashboard...
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta5/aio/deploy/recommended.yaml

    #Verify Kubernetes Master Node Is Up and Running
    echo 
    echo Verify Kubernetes Master Node Is Up and Running...
    kubectl get nodes

    #End Master Node Configuration
    break;
    ;;
	
	S)

    # Init Variables
    echo Configuring Kube Slave Node....
    echo
    echo You will need your Kubernetes Master Host IP, Token and Hash to continue...
    echo
    echo Enter Kubernetes Master Host IP Address:
    read KubeMasterHostIP
    echo Enter Kubernetes Master Host Token
    read KubeMasterToken
    echo Enter Kubernetes Master Host Hash
    read KubeMasterHash
    
    # Join Kubernetes Cluster
    echo Joining Slave Node To Master Host $KubernetesMasterHostIP...
    sudo kubeadm join $KubeMasterHostIP:6443 --token $KubeMasterToken --discovery-token-ca-cert-hash sha256:$KubeMasterHash

    #Verify Master Is Up
    echo Verify Kubernetes Node Has Been Added Successful...
    kubectl get nodes
    
    break;
    ;;
	*)
    echo Please Select A Valid Role...
    ;;
  esac
done

# Housekeeping
echo Doing A Little Housekeeping....
rm -f build_kube_node.sh

# Reboot
echo Rebooting in 5 seconds...
sleep 5
sudo reboot now
