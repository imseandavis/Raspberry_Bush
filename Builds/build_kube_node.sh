#!/bin/sh

# Install Docker
echo Installing Docker...
curl -sSL get.docker.com | sh && \
sudo usermod -aG docker pi

# Add Repo List
echo Adding Kubernetes Repos...
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

#Install & Upgrade All Packages - Have To Use APT-GET Due To Some Kubernetes Nuances
echo Updating and Upgrading Packages...
sudo apt-get update -qy && \
sudo apt-get upgrade -qy

# Install KubeADM
echo Installing KubeADM...
sudo apt-get install -qy kubeadm

#Download Config Files
echo "Pick A Role To Install: (M)aster Node or (S)lave Node"
while :
do
  read INPUT_STRING
  case $INPUT_STRING in
	M)
    echo Configuring Kube Master Node....
    
    # Download Kubernetes Config Images
    echo Downloading Kubernetes Config Images...
    sudo kubeadm config images pull
    
    # Init KubeAdm
    echo Init KubeAdm...
    sudo kubeadm init

    # Start Kube Cluster
    echo Start Kube Cluster...
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

    #Verify Kubernetes Master Node Is Up and Running
    echo 
    echo Verify Kubernetes Master Node Is Up and Running...
    kubectl get nodes
    
    # Install Weave Network 
    kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
    
    # Install WebUI Dashboard
    kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml
    
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
    sudo kubeadm join $KubeMasterHostIP:6443 --token $KubeMasterToken --discovery-token-ca-cert-hash $KubeMasterHash

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
#rm -f config_kube.sh

# Reboot
echo Rebooting in 5 seconds...
sleep 5
sudo reboot now
