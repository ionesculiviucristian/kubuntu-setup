#!/bin/bash

set -eu

# If you already have nvidia regular drivers installed
# sudo apt --purge remove '*nvidia*${DRIVER_BRANCH}*'

# cat <<EOF | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
# blacklist nouveau
# options nouveau modeset=0
# EOF

# sudo update-initramfs -u
# reboot

# Install CUDA enabled drivers alonside NVIDIA Container Toolkit
wget https://developer.download.nvidia.com/compute/cuda/12.5.0/local_installers/cuda_12.5.0_555.42.02_linux.run
chmod +x cuda_12.5.0_555.42.02_linux.run
sudo ./cuda_12.5.0_555.42.02_linux.run --silent --driver --toolkit --override
rm -f cuda_12.5.0_555.42.02_linux.run
echo 'export PATH="/usr/local/cuda/bin:$PATH"' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH="/usr/local/cuda-12.5/lib64"' >> ~/.bashrc

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

sudo nvidia-ctk runtime configure --runtime=docker
sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
