#!/bin/bash

set -eu

# Start with this script, if it exists
if [ -e /usr/bin/nvidia-uninstall ]; then
    sudo /usr/bin/nvidia-uninstall
fi

# Generic uninstall
sudo apt purge "*nvidia*"
sudo apt autoremove

# Manual uninstall
# sudo ~/.drivers/NVIDIA-Linux-x86_64-555.58.02.run --uninstall

# Make sure nouveau is restored
# cat /proc/cmdline | grep nouveau
# sudo lsinitramfs /boot/initrd.img-$(uname -r) | grep nouveau

sudo rm -f /etc/modprobe.d/nvidia-installer-disable-nouveau.conf
sudo rm -f /usr/lib/modprobe.d/nvidia-installer-disable-nouveau.conf

# Most likely created by nvidia; if it's present after uninstall
# then it could bring down the whole planet so it's better to play it safe
if [ -e /etc/X11/xorg.conf ]; then
    sudo mv /etc/X11/xorg.conf /etc/X11/xorg.conf.bak
fi

sudo update-initramfs -u -k all
sudo sed -i 's/GRUB_CMDLINE_LINUX=".*"/GRUB_CMDLINE_LINUX=""/' /etc/default/grub
sudo update-grub
sudo reboot
