#!/bin/bash

set -eu

echo "blacklist i2c_nvidia_gpu" | sudo tee -a /etc/modprobe.d/blacklist_i2c-nvidia-gpu.conf
sudo update-initramfs -u

sudo mkdir /etc/systemd/system/bluetooth.service.d
echo -e "[Service]\nExecStart=\nExecStart=/usr/libexec/bluetooth/bluetoothd --noplugin=sap" | sudo tee -a /etc/systemd/system/bluetooth.service.d/01-disable-sap-plugin.conf
sudo systemctl daemon-reload
sudo systemctl restart bluetooth.service
