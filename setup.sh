#!/bin/sh

#Download Config Files
echo "Pick A Role To Install: (M)aster Node or (S)lave Node 
while :
do
  read INPUT_STRING
  case $INPUT_STRING in
	M)
    echo Downloading Kube Master Node Config File....
    sudo curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/build_kube_master.sh -o build_kube_master.sh
    break;
    ;;
	S)
    echo Downloading Kube Slave Node Config File....
    sudo curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/build_kube_slave.sh -o build_kube_slave.sh
    break;
    ;;
	*)
    echo "Please Select A Valid Role..."
    ;;
  esac
done

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

# Housekeeping
echo Cleaning up....
rm -f setup.sh

# Reboot
echo Rebooting in 5 seconds...
sleep 5
sudo reboot now
