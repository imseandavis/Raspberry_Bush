#!/bin/sh

# Turn on SSH
echo Turning on SSH...
sudo touch /boot/ssh

#Init Variables
hostname=$1
ip=$2 #IP
gateway=$3 #IP Format
dns=$4 #IP Format

# Update Hostname
echo Setting Hostname...
sudo hostnamectl --transient set-hostname $hostname
sudo hostnamectl --static set-hostname $hostname
sudo hostnamectl --pretty set-hostname $hostname
sudo sed -i 's/raspberrypi/$hostname/g' /etc/hosts

# Set the static ip
echo Setting Static IP to: $ip ...
sudo cat <<EOT >> /etc/dhcpcd.conf
interface eth0
static ip_address=$ip/24
static routers=$gateway
static domain_name_servers=$dns
EOT

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
echo Downloading config files....
sudo curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/Config_Kubernetes_Master.sh -o config.sh
sudo curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/kubeadm_conf.yaml -o kubadm_conf.yaml

# Housekeeping
echo Cleaning up....
rm -f build_kub_node.sh

# Reboot
echo Rebooting in 5 seconds...
sleep 5
sudo reboot now
