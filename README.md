# Last Updated: 10/29/2019
## Built For Raspberry Pi (3/4)
## Software Builds:
 - k3s
   - STUFF GOES HERE
 - k8s
   - Raspbian Buster Lite (Kernel 4.19)
   - Custom CPU Governor Plugin 1.0
   - Kubernetes 1.16.2
   - Docker-CE 19.03.4
   - Flannel 0.11.0
   - WebUI 2.0.0 Beta5

# Overview
This is a project to help you create a Raspberry Pi cluster and demo DevOps practices from build/release to Chaos Engineering on it. According to a few friends, it's been deemed a Raspberry Bush. Credit for the name goes to Antony Zimzores. Check out the companion blog article [here](https://www.seanasaservice.com/blog/raspberry-bush). 

# Cost
 - Raspberry Pi 3B+ based cluster will cost around $850 for an 8 node cluster with the following specs: 24 Cores @ 1.4GHz / 6GB RAM / 384GB Storage (This Assumes a Lab Desktop, Master Node, and 6 Slave Nodes). Network is limited to 300MB max throughput as it's bound to the same bus as the USB.

 - Raspberry Pi 4B (4GB) based cluster will cost around $1000 for an 8 node cluster with the following specs: 32 Core @ 1.5GHz / 32GB RAM / 384GB Storage (This Assumes a Lab Desktop, Master Node, and 6 Slave Nodes). If you need a bit more umph this build will also provide the benefit of a full 1GB network vs. 300MB of the Pi 3B+.

# Build Materials
There are two ways you can build this, I chose to go the Power over Ethernet (PoE) route as the switch I chose provided me with and additional two 1GB uplink ports (whihc my chosen switch) and gave me the ability to consolidate the need for power into a single connection to the Pi. When I did the cost analysis, the additional price of the PoE Hats + PoE Switch was only around $100 difference so it didn't make sense not to go with the cleaner look, less cables, one less power supply, and 2 additional network ports. Feel free to use whatever switch you like as long as it doesnt exceed the INTERIOR dimensions of the case your using. Luckily I pulled spec sheets on all switches considered and found a fair compromise of what I wanted and kept things tidy and simple. I did wish that had gone with 128GB cards but those cards get expensive when your buying 8, your wallets milage may vary. I highly reccomend the SanDisk Extreme Pro models as the performance is great and has the best perf/dollar ratio.
  
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

#### Minimum
   - 3x [Raspberry PI 3B+]()
   - 3x [Raspberry Pi 3B+ Power Supply]()
   - 3x [SD Card - Minimum 16GB]()
   
#### Recommended
   - Pi3 Cluster
     - 8x [CanaKit Raspberry Pi 3 B+](https://www.canakit.com/raspberry-pi-3-model-b-plus.html) ($35/ea.)
     - 8x [CanaKit Raspberry Pi PoE Hat](https://www.canakit.com/raspberry-pi-poe-hat.html) ($20/ea.)
     - 8x [SanDisk Extreme Pro 64GB Micro SD Card](https://www.bestbuy.com/site/sandisk-extreme-plus-64gb-microsdxc-uhs-i-memory-card/6282920.p?skuId=6282920) ($34.99/ea.)
     - [.5ft Network Cables](https://www.amazon.com/gp/product/B06Y4722LW) ($12.59/10 Pack)
     - 1x [YuanLey Smart PoE Switch](https://www.amazon.com/gp/product/B07H8YN9C3) ($59.99)
     - 1x [C4 Labs Raspberry Pi Cluster Enclosure – Black Ice](https://www.c4labs.com/product/8-slot-stackable-cluster-case-raspberry-pi-3b-and-other-single-board-computers-color-options/) ($46.99)

   - Optional Non PoE Build (Won't be able to use the same case)
     - 1x [Anker 60W 10 Port USB](https://www.amazon.com/Anker-10-Port-Charger-PowerPort-iPhone/dp/B00YRYS4T4) ($39.99)
     - 8x [Micro USB Cables](https://www.amazon.com/Sabrent-6-Pack-Premium-Cables-CB-UM61/dp/B011KMSNXM) ($7.99)
   
  - Pi4 Cluster 
    - 8x [Raspberry Pi 4B (4GB)]()
    - 8x [Raspberry Pi 4B Power Supply]()
    - 8x [SD Card - Minimum 64GB]()
    - 8x [SanDisk Extreme Pro 64GB Micro SD Card](https://www.bestbuy.com/site/sandisk-extreme-plus-64gb-microsdxc-uhs-i-memory-card/6282920.p?skuId=6282920) ($34.99/ea.)
    - [.5ft Network Cables](https://www.amazon.com/gp/product/B06Y4722LW) ($12.59/10 Pack)
    - 1x [YuanLey Smart PoE Switch](https://www.amazon.com/gp/product/B07H8YN9C3) ($59.99)
    - 1x [C4 Labs Raspberry Pi Cluster Enclosure – Black Ice](https://www.c4labs.com/product/8-slot-stackable-cluster-case-raspberry-pi-3b-and-other-single-board-computers-color-options/) ($46.99)

   - Optional Non PoE Build (Won't be able to use the same case)
     - 1x [Anker 60W 10 Port USB](https://www.amazon.com/Anker-10-Port-Charger-PowerPort-iPhone/dp/B00YRYS4T4) ($39.99)
     - 8x [Micro USB Cables](https://www.amazon.com/Sabrent-6-Pack-Premium-Cables-CB-UM61/dp/B011KMSNXM) ($7.99)
</p>
</details>


# Prerequisite Software
  - Software To Burn SD Card Images - [Etcher.io](https://www.balena.io/etcher/)
  - SD Card Image - [Raspbian Buster Lite](https://www.raspberrypi.org/downloads/raspbian/)


# Image SD Card
  - Download the Raspbian Lite Image and and Extract the ISO
  - Flash To SD Card With Etcher
  * Note: After Flashing With Etcher Windows Your Pi May Reboot One Extra Time To Resize Partitions (This is Normal)


## Desktop Node Setup
Desktop Node will be the standalone workstation (in your cluster) from which everything is ran and learned. This will also be where we execute our DevOps and Chaos engineering consoles from as well. We'll also install all our tools on here as well. Consider it the desktop machine you would work from and where you'll install all your tools you'll learn from will reside. To be continued...
  -

## Raspbian Kubernetes Node (Master / Slave) Setup
These machines will house the Kubernetes clusters, both master and slave, for use as a container platform to deploy our DevOps solutions and test projects.
  - First Login To the Raspberry Pi For The First Time With The Credentials: pi/raspberry
  - Change Your Root Password: <code> passwd </code>
  - (Optional) Configure Your Time Zone: <code> tzselect </code>
  - (Optional) Set Your Wifi Country: <code> sudo iw reg set [Two Letter Country Code] </code>
  - (Optional) Turn on SSH: <code> sudo touch /boot/ssh && sudo service ssh start</code>
  - Download the setup package by running the following command:
    - <code>curl -sSL https://tiny.cc/buildrb -o setup.sh</code>
  - Run the pi config script by running the following command:
    - <code> sudo sh setup.sh [Version (k3s/k8s)] [Node Type (Master/Worker)] [Hostname] [Desired IP] [Desired Gateway IP] [Desired DNS Server IP]</code>
    - This process will take about 15 seconds.
  - After reboot, run the node setup script by running the following command:
    - <code> sudo sh build_kub_node.sh</code>
    - This process will take between 10-15 minutes (will vary based on sd card speed).

## Ubuntu Mate Kubernetes Node
Not working yet...

## Windows Node (Why? Because I Can - Only for RPI 4, RPI3 is super buggy and insanely slow.)
If you are interested in standing up a single instance of Windows to deploy full .NET Core apps natively to in order to compare performance or just because you want to, here's your build. Otherwise goe with .net core and stick yo linux.
   - Download the tool to install Windows on pie [here](https://github.com/WOA-Project/WOA-Deployer-Rpi)
   - Follow the instructions [here](https://github.com/WOA-Project/guides/blob/master/GettingWOA.md) to obtain a Windows on ARM WIM Image
   - Install The Image Using The WOA Installer
   - Profit!
   
## Performance Tests
Raspberry Pi 4B Build Times
  - Setup - 13 Seconds
  - k3s Build - ????
  - k8s Build - 8m 21s
  
MORE COMING SOON.....
