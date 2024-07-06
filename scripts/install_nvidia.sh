#!/bin/bash

set -eu

# Usefull to check if the client and the kernel have different driver versions 
# dkms status

# Automatic installation
sudo ubuntu-drivers install
sudo update-initramfs -u -k all
sudo reboot
# sudo prime-select nvidia
# sudo reboot

# Generic installation
# sudo ubuntu-drivers list
# sudo apt install nvidia-driver-535

# Manual installation
# openssl req -new -x509 -newkey rsa:4096 -keyout ~/.ssh/nvidia-module-private.key -outform DER -out ~/.ssh/nvidia-module-public.key -nodes -days 3650 -subj "/CN=nvidia-kernel-module"
# sudo mokutil --import ~/.ssh/nvidia-module-public.key
# reboot

# wget -P ~/.drivers https://us.download.nvidia.com/XFree86/Linux-x86_64/555.58.02/NVIDIA-Linux-x86_64-555.58.02.run
# chmod +x ~/.drivers/NVIDIA-Linux-x86_64-555.58.02.run
# sudo ~/.drivers/NVIDIA-Linux-x86_64-555.58.02.run \
#   --module-signing-secret-key=${HOME}/.ssh/nvidia-module-private.key \
#   --module-signing-public-key=${HOME}/.ssh/nvidia-module-public.key
