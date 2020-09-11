# Last Updated: 09/11/2020 4:05pm
## Built For Raspberry Pi (3B+/4B)
## Software Builds:
 - k3s (Updated 9/11/2020)
   - k3s Service 1.18.8+k3s1
   - kernel 5.4.51-v71+
   - containerd 1.3.3-k3s2
 - k8s (Updated Happening In Oct 2020)
   - Raspbian Buster Lite (Kernel 5.4) (Release Date Used: 08-20-2020)
   - Custom CPU Governor Plugin 1.0 (Now Built It Script)
   - Kubernetes 1.16.15
   - Docker-CE 19.03.4
   - Flannel 0.11.0
   - WebUI 2.0.0 Beta5

# Overview
This is a project to help you create a Raspberry Pi cluster and demo DevOps practices from build/release to Chaos Engineering on it. According to a few friends, it's been deemed a Raspberry Bush. Credit for the name goes to Antony Zimzores. Check out the companion blog article [here](https://www.seanasaservice.com/blog/raspberry-bush). 

# Cost
 - Raspberry Pi 3B+ based cluster will cost around $850 for an 8 node cluster with the following specs: 28 Cores @ 1.4GHz / 7GB RAM / 896GB Storage (This Assumes a Lab Desktop, Master Node, and 6 Worker Nodes). Network is limited to 300MB max throughput as it's bound to the same bus as the USB.

 - Raspberry Pi 4B (4GB) based cluster will cost around $1000 for an 8 node cluster with the following specs: 28 Cores @ 1.5GHz / 28GB RAM / 896GB Storage (This Assumes a Lab Desktop, Master Node, and 6 Worker Nodes). If you need a bit more power, this build will also provide the benefit of a full 1GB network.

# Build Materials
There are two ways you can build this, I chose to go the Power over Ethernet (PoE) route as the switch I chose provided me with and additional two 1GB uplink ports (my chosen switch) and gave me the ability to consolidate the need for power into a single connection to the Pi. When I did the cost analysis, the additional price of the PoE Hats + PoE Switch was around $225 difference and gave me a cleaner look, less cables, 8 less power supplies, and 2 additional network ports. Feel free to use whatever switch you like as long as it doesnt exceed the INTERIOR dimensions of the case your using. Luckily I pulled spec sheets on all switches considered and found a fair compromise of what I wanted and kept things tidy and simple. I highly recommend the SanDisk Extreme Plus models as the performance is great and has the best perf/dollar ratio.
  
<details>
<summary>Single Node Builds</summary>
<p>

#### Minimum
   - 1x [Raspberry PI 3B+]()
   - 1x [Raspberry Pi 3B+ Power Supply]()
   - 1x [SD Card - Minimum 16GB]()
   
#### Recommended
   - 1x [Raspberry Pi 4B]()
   - 1x [Raspberry Pi 4B Power Supply]()
   - 1x [SD Card - Minimum 64GB]()

</p>
</details>

<details>
<summary>Cluster Builds</summary>
<p>

#### Pi3B+ Minimum
   - 2x [Raspberry PI 3B+]()
   - 2x [Raspberry Pi 3B+ Power Supply]()
   - 2x [SD Card - Minimum 16GB]()
   
#### Recommended
   - 8x [Raspberry Pi 4B]()
   - 8x [Raspberry Pi 4B Power Supply]()
   - 8x [SD Card - Minimum 64GB]()
   - 1x [PoE Switch]()
   - 1x [8 Node Cluster Case]()
</p>
</details>


<details>
<summary>Bill of Materials</summary>
<p>
 
#### Pi 3B+ Cluster
   - Pi3 Cluster
     - 8x [CanaKit Raspberry Pi 3 B+](https://www.canakit.com/raspberry-pi-3-model-b-plus.html) ($35/ea.)
     - 8x [CanaKit Raspberry Pi PoE Hat](https://www.canakit.com/raspberry-pi-poe-hat.html) ($20/ea.)
     - 8x [SanDisk Extreme Plus 128GB Micro SD Card](https://www.bestbuy.com/site/sandisk-extreme-plus-128gb-microsdxc-uhs-i-memory-card/6282919.p?skuId=6282919) ($33.99/ea.)
     - [.5ft Network Cables](https://www.amazon.com/gp/product/B06Y4722LW) ($12.59/10 Pack)
     - 1x [YuanLey Smart PoE Switch](https://www.amazon.com/gp/product/B07H8YN9C3) ($59.99)
     - 1x [C4 Labs Raspberry Pi Cluster Enclosure – Black Ice](https://www.c4labs.com/product/8-slot-stackable-cluster-case-raspberry-pi-3b-and-other-single-board-computers-color-options/) ($46.99)

   - Optional Non PoE Build (Won't be able to use the same case)
     - 1x [Anker 60W 10 Port USB](https://www.amazon.com/Anker-10-Port-Charger-PowerPort-iPhone/dp/B00YRYS4T4) ($39.99)
     - 8x [Micro USB Cables](https://www.amazon.com/Sabrent-6-Pack-Premium-Cables-CB-UM61/dp/B011KMSNXM) ($7.99)

#### Pi 4B Cluster
   - Pi4 Cluster 
     - 8x [Raspberry Pi 4B (4GB)]()
     - 8x [Raspberry Pi 4B Power Supply]()
     - 8x [SD Card - Minimum 64GB]()
     - 8x [SanDisk Extreme Plus 128GB Micro SD Card](https://www.bestbuy.com/site/sandisk-extreme-plus-128gb-microsdxc-uhs-i-memory-card/6282919.p?skuId=6282919) ($33.99/ea.)
     - [.5ft Network Cables](https://www.amazon.com/gp/product/B06Y4722LW) ($12.59/10 Pack)
     - 1x [YuanLey Smart PoE Switch](https://www.amazon.com/gp/product/B07H8YN9C3) ($59.99)
     - 1x [C4 Labs Raspberry Pi Cluster Enclosure – Black Ice](https://www.c4labs.com/product/8-slot-stackable-cluster-case-raspberry-pi-3b-and-other-single-board-computers-color-options/) ($46.99)
     - 1x [GANA Micro HDMI To HDMI Adapter](https://www.amazon.com/gp/product/B07K21HSQX/ref=ppx_yo_dt_b_asin_title_o03_s00?ie=UTF8&psc=1) (7.99)

   - Optional Non PoE Build (Won't be able to use the same case)
     - 1x [Anker 60W 10 Port USB](https://www.amazon.com/Anker-10-Port-Charger-PowerPort-iPhone/dp/B00YRYS4T4) ($39.99)
     - 8x [Micro USB Cables](https://www.amazon.com/Sabrent-6-Pack-Premium-Cables-CB-UM61/dp/B011KMSNXM) ($7.99)
      
   - Optional Screen
     - 1x [3.5 Pi Case + Screen](https://www.amazon.com/Raspberry-320x480-Monitor-Raspbian-RetroPie/dp/B07N38B86S/)
      
</p>
</details>


# Prerequisite Software
  - Software To Burn SD Card Images - [Etcher.io](https://www.balena.io/etcher/)
  - SD Card Image - [Raspbian Buster Lite](https://downloads.raspberrypi.org/raspios_lite_armhf_latest)


# Image SD Card
  - Download the Raspbian Lite Image and and Extract the ISO
  - Flash To SD Card With Etcher
  * Note: After Flashing With Etcher Windows On First Boot Your Pi May Reboot One Extra Time To Resize Partitions (This is Normal)


## Desktop Node Setup
Desktop Node will be the standalone workstation (in your cluster) from which everything is ran and learned. This will also be where we execute our DevOps and Chaos engineering consoles from as well. We'll also install all our tools on here as well. Consider it the desktop machine you would work from and where you'll install all your tools you'll learn from will reside. Thinking Ubuntu Mate Maybe??? To be continued...

### Linux Desktop Node (Coming soon...)
Pretty standard stuff here...
  - Download the [Raspberry Pi Desktop Image](https://www.raspberrypi.org/downloads/raspberry-pi-os/) and Flash to SD with Etcher
  - (Coming soon...) Install your tools by running the command: <code>sudo sh installtools.sh</code>
  

### Windows Desktop Node (Raspberry Pi 4B Only)
For the Windows Desktop node there is a niche group out there thats super passionate about Windows on RPI, here's how to get started:
  - Go to the [WoRP Project Page](https://www.worproject.ml/downloads) and download the WoRP Imager
  - Sign up for the [WoRP Discord channel](https://discord.com/invite/jQCpfVK) and follow the instructions to get access to the WoRP Image
  - Run the downloaded WoRP tool and follow the instructions
  - Go get a snack, the instal will take ~35 minutes
  - Load up the SD card in your RPi and boot
  - Initial boot will take ~7 minutes and will auto-reboot (It will look like it's froze for the first few minutes, just leave it)
  - Second boot will take ~4 minutes and will take you to the OOBE screen, answer the questions and you're all set.


## Raspbian Kubernetes Node (Master / Worker) Setup
These machines will house the Kubernetes cluster(s), both master and worker nodes, for use as a container platform to deploy our DevOps solutions and test projects.
  - First Login To the Raspberry Pi For The First Time With The Credentials: pi/raspberry
  - Change Your Root Password: <code> passwd </code>
  - (Optional) Configure Your Time Zone: <code> tzselect </code>
  - (Optional) Set Your Wifi Country: <code> sudo iw reg set [Two Letter Country Code] </code>
  - (Optional) Turn on SSH: <code> sudo touch /boot/ssh && sudo service ssh start</code>
  - Download the setup package by running the following command:
    - <code>curl -sSL https://tiny.cc/buildrb -o setup.sh</code>
  - Run the pi config script by running the following command:
    - <code> sudo sh setup.sh [Version (k3s/k8s)] [Node Type (Master/Worker)] [Hostname] [Desired IP] [Desired Gateway IP] [Desired DNS Server IP]</code>
    - Example K8s Master Build: <code> sudo sh setup.sh k8s Master kube-master 192.168.1.2 192.168.1.1 192.168.1.1 </code>
    - This process will take about 15 seconds.
  - After reboot, run the node setup script by running the following command:
    - <code> sudo sh build_kub_node.sh</code>
    - This process will take between 10-15 minutes (will vary based on sd card speed).

## k3s Additional Container Installs (Will Customize Later)
  - [Reference Install Guide](https://kauri.io/38-install-and-configure-a-kubernetes-cluster-with/418b3bc1e0544fbc955a4bbba6fff8a9/a)
    - Helm: Package manager for Kubernetes
    - MetalLB: Load-balancer implementation for bare metal Kubernetes clusters
    - Nginx: Kubernetes Ingress Proxy
    - Cert Manager: Native Kubernetes certificate management controller.
    - Kubernetes Dashboard: A web-based Kubernetes user interface
    
## k8s Additional Installs (Will Update In Oct 2020)
Coming Soon...

## Performance Tests
Raspberry Pi 4B Build Times
  - Setup - 13 seconds
  - k3s Build - ~1 minute
  - k8s Build - 13m 42s

## DevOps Tools
MORE COMING SOON.....

## What's Next???
For more Pi fun, this time try Pizza Pi, write your first app to deploy and automate pizza orders from Dominos. Get started here: https://github.com/gamagori/pizzapi

## Free Follow On Education
[K8S Sandbox Learning Labs](https://labs.play-with-k8s.com) <br>
[Kubernetes Browser Based Training](https://www.katacoda.com/courses/kubernetes)
