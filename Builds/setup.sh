#!/bin/sh

#Init Variables
hostname=$1
ip=$2
gateway=$3
dns=$4

# Disable Swap File
echo Disabling Swap File...
sudo dphys-swapfile swapoff && \
sudo dphys-swapfile uninstall && \
sudo update-rc.d dphys-swapfile remove && \
sudo systemctl disable dphys-swapfile > /dev/null 2>&1

#Disable Raspi-Config
echo Disabling Raspberry Pi Config Tool...
sudo systemctl disable raspi-config > /dev/null 2>&1

# Set Governor To Performance
echo  Set CPU Governor To Performance...
wget https://raw.githubusercontent.com/DavidM42/rpi-cpu.gov/master/install.sh > /dev/null 2>&1 && sudo chmod +x ./install.sh > /dev/null 2>&1 && sudo ./install.sh --nochown > /dev/null 2>&1 && sudo rm install.sh > /dev/null 2>&1
cpu.gov -g performance > /dev/null

# Disable IPv6 & Enable CGROUPS
echo Disabling IPv6 and Enabling CGROUPS...
sudo cp /boot/cmdline.txt /boot/cmdline_backup.txt
orig="$(head -n1 /boot/cmdline.txt) ipv6.disable=1 cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1"
echo $orig | sudo tee /boot/cmdline.txt > /dev/null 2>&1

# Download Kube Node Build Script
echo Downloading Kube Node Build Script...
curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/Builds/build_kube_node.sh -o build_kube_node.sh

# Set Static IP
echo Setting Static IP to: $ip ...
sudo cat <<EOT >> /etc/dhcpcd.conf
interface eth0
static ip_address=$ip/24
static routers=$gateway
static domain_name_servers=$dns
EOT

# Update Hostname
echo Setting Hostname to $hostname...
sudo hostnamectl --transient set-hostname $hostname > /dev/null 2>&1
sudo hostnamectl --static set-hostname $hostname > /dev/null 2>&1
sudo hostnamectl --pretty set-hostname $hostname > /dev/null 2>&1
sudo sed -i s/raspberrypi/$hostname/g /etc/hosts > /dev/null 2>&1

# Housekeeping
echo Cleaning up....
rm -f setup.sh

# Reboot
echo Rebooting in 5 seconds...
sleep 5
sudo reboot now
