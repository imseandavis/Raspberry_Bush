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
sudo sed -i s/raspberrypi/$hostname/g /etc/hosts

# Set the static ip
echo Setting Static IP to: $ip ...
sudo cat <<EOT >> /etc/dhcpcd.conf
interface eth0
static ip_address=$ip/24
static routers=$gateway
static domain_name_servers=$dns
EOT

# Disable Swap (Requires A Reboot To Take Effect)
echo Disabling Swap...
sudo dphys-swapfile swapoff && \
sudo dphys-swapfile uninstall && \
sudo update-rc.d dphys-swapfile remove

# Enable CGROUPS
echo Enabling CGROUPS...
sudo cp /boot/cmdline.txt /boot/cmdline_backup.txt
orig="$(head -n1 /boot/cmdline.txt) cgroup_enable=cpuset cgroup_enable=memory"
echo $orig | sudo tee /boot/cmdline.txt > /dev/null

# Download Kube Node Build Script
echo Downloading Kube Node Build Script...
curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/Builds/build_kube_node.sh -o build_kube_node.sh

# Housekeeping
echo Cleaning up....
rm -f setup.sh

# Reboot
echo Rebooting in 5 seconds...
sleep 5
sudo reboot now