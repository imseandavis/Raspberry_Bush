# Last Updated: 2/19/2019 - Built For Kubernetes v1.13.3

# Overview
This is a project to help you create a Raspberry Pi cluster and demo DevOps practices from build/release to Chaos Engineering on it. According to a few friends, it's called a Raspberry Bush. Credit for the name goes to Antony Zimzores. Check out the companion blog article that goes into greater detail of thre build and process, [here](https://www.seanasaservice.com/blog/raspberry-bush). Altogether it cost around $850 and provided me with a lab with the following specs: 24 Cores @ 1.4GHz / 6GB RAM / 384GB Storage


# Build Materials
There are two ways you can build this, I chose to go the Power over Ethernet (PoE) route as the switch I chose provided me with and additional two 1GB uplink ports and gave me the ability to consolidate the need for power into a single connection to the Pi. When I did the cost analysis, the additional price of the PoE Hats + PoE Switch was only around $100 difference so it didn't make sense not to go with the cleaner look, less cables, one less power supply, and 2 additional network ports. Feel free to use whatever switch you like as long as it doesnt exceed the INTERIOR dimensions of the case your using. Luckily I pulled spec sheets on all switches considered and found a fair compromise of what I wanted and kept things tidy and simple. I did wish that had gone with 128GB cards but those cards get expensive when your buying 8, your wallets milage may vary. I highly reccomend the extreme pro models as the performance is great.

  - Required
    - 8x [CanaKit Raspberry Pi 3 B+](https://www.canakit.com/raspberry-pi-3-model-b-plus.html) ($35/ea.)
    - 8x [CanaKit Raspberry Pi PoE Hat](https://www.canakit.com/raspberry-pi-poe-hat.html) ($20/ea.)
    - 8x [SanDisk Extreme Pro 64GB Micro SD Card](https://www.bestbuy.com/site/sandisk-extreme-plus-64gb-microsdxc-uhs-i-memory-card/6282920.p?skuId=6282920) ($34.99/ea.)
    - [.5ft Network Cables](https://www.amazon.com/gp/product/B06Y4722LW) ($12.59/10 Pack)
    - 1x [YuanLey Smart PoE Switch](https://www.amazon.com/gp/product/B07H8YN9C3) ($59.99)
    - 1x [C4 Labs Raspberry Pi Cluster Enclosure – Black Ice](https://www.c4labs.com/product/8-slot-stackable-cluster-case-raspberry-pi-3b-and-other-single-board-computers-color-options/) ($46.99)

  - Optional Non PoE Build (Won't be able to use the same case)
    - 1x [Anker 60W 10 Port USB](https://www.amazon.com/Anker-10-Port-Charger-PowerPort-iPhone/dp/B00YRYS4T4) ($39.99)
    - 8x [Micro USB Cables](https://www.amazon.com/Sabrent-6-Pack-Premium-Cables-CB-UM61/dp/B011KMSNXM) ($7.99)
    

# Prerequisite Software
  - Software To Burn SD Card Images - [Etcher.io]()
  - SD Card Image - [Raspbian Stretch Lite]()
  

# Image SD Card
  - Download the Raspbian Stretch Lite Image and and Extract the ISO
  - Flash To SD Card With Etcher


# Command Central Setup
Command central will be the standalone workstation from which everything is ran. This will also be where we run our DevOps and Choas jobs from as well. To be continued....

# Kubernetes Master Node Setup
  - First Login To the Raspberry Pi For The First Time With The Credentials: pi/raspberry
  - Change Your Root Password
  - Download the setup package by running the following command:
    - <code>curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/setup.sh -o setup.sh</code>
  - Run the pi config script by running the following command:
    - <code> sudo sh setup.sh [Hostname] [Desired IP] [Desired Gateway IP] [Desired DNS Server IP]</code>
  - After reboot, run the node setup script by running the following command:
    - <code> sudo sh build_kub_node.sh</code>
    - This process will take between 10-12 minutes (will vary based on sd card speed) and will reboot when completed.
  - After reboot, run the kubernetes master node configuration script by running the following command:
    - <code> sudo sh config_kub_master.sh </code>


# Other Housekeeping (Optional)
2.	Setup Time Zone – Option 4, I2
3.	Setup WiFi Country – Option 4, I4
4.	Update Raspi Config – Option 8)
