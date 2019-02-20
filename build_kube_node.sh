#!/bin/sh



# Install Docker
#echo Installing Docker...
export VERSION=18.06.0 && \
curl -sSL get.docker.com | sh && \
sudo usermod -aG docker pi

# Disable Swap
echo Disabling Swap...
sudo dphys-swapfile swapoff && \
sudo dphys-swapfile uninstall && \
sudo update-rc.d dphys-swapfile remove
echo Adding " cgroup_enable=cpuset cgroup_enable=memory" to /boot/cmdline.txt
sudo cp /boot/cmdline.txt /boot/cmdline_backup.txt
orig="$(head -n1 /boot/cmdline.txt) cgroup_enable=cpuset cgroup_enable=memory"
echo $orig | sudo tee /boot/cmdline.txt

# Add Repo List and Install KubeADM
echo Installing KubeADM...
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
sudo apt-get update -q && \
sudo apt-get install -qy kubeadm

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
    sudo kubeadm init

    # Start Kube Cluster
    echo Start Kube Cluster...
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

    #Verify Kubernetes Master Node Is Up and Running
    echo Verify Kubernetes Master Node Is Up and Running...
    kubectl get nodes
    
    break;
    ;;
	S)
    echo Configuring Kube Slave Node....
    
    # Update Kube Config
    echo Join Kube Slave Node To Master...
    sudo kubeadm join --token TOKEN 192.168.1.100:6443 --discovery-token-ca-cert-hash HASH

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
echo Rebooting in 10 seconds...
sleep 10
sudo reboot now
