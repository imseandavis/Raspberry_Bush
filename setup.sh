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
