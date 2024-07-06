#!/bin/bash

set -eu

# Automatic installation
# sudo ubuntu-drivers install

# Generic installation
# sudo ubuntu-drivers list
sudo apt install nvidia-driver-535

# Manual installation
wget -P ~/.drivers https://us.download.nvidia.com/XFree86/Linux-x86_64/555.58.02/NVIDIA-Linux-x86_64-555.58.02.run
chmod +x ~/.drivers/NVIDIA-Linux-x86_64-555.58.02.run
sudo ~/.drivers/NVIDIA-Linux-x86_64-555.58.02.run \
  --module-signing-secret-key=~/.ssh/nvidia-module-private.key \
  --module-signing-public-key=~/.ssh/nvidia-module-public.key
