#!/bin/bash

set -eu

# Generic uninstall
sudo apt purge nvidia*
sudo apt autoremove

# Manual uninstall
# sudo ~/.drivers/NVIDIA-Linux-x86_64-555.58.02.run --uninstall

# Make sure nouveau is restored
# cat /proc/cmdline | grep nouveau
# sudo lsinitramfs /boot/initrd.img-$(uname -r) | grep nouveau

sudo rm -f /etc/modprobe.d/nvidia-installer-disable-nouveau.conf
sudo rm -f /usr/lib/modprobe.d/nvidia-installer-disable-nouveau.conf

sudo update-initramfs -u
sudo reboot
