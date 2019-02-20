#!/bin/sh

# Install Docker
echo Installing Docker...
curl -sSL get.docker.com | sh && \
sudo usermod pi -aG docker

# Disable Swap
echo Disabling Swap File...
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
echo Downloading Master Node Config Files....
sudo curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/config_kube_master.sh -o config_kube_master.sh
sudo curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/kubeadm_conf.yaml -o kubeadm_conf.yaml

# Housekeeping
echo Cleaning up....
rm -f build_kube_node.sh

# Reboot
echo Rebooting in 5 seconds...
sleep 5
sudo reboot now
