#!/bin/sh

# Download Demo Scripts
echo Downloading Demo Scripts...
curl -sSL https://raw.githubusercontent.com/imseandavis/Raspberry_Bush/master/Builds/k8s/demo_deploy.sh -o demo_deploy.sh

# Cleanup Remaining Files
rm -f post_install_tasks.sh
