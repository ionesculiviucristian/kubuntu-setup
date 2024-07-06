#!/bin/bash

set -eu

# If you already have nvidia regular drivers installed
# sudo apt --purge remove '*nvidia*535*'

# reboot

# cat <<EOF | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
# blacklist nouveau
# options nouveau modeset=0
# EOF

# sudo update-initramfs -u

# Install CUDA enabled drivers alonside NVIDIA Container Toolkit
openssl req -new -x509 -newkey rsa:4096 -keyout ~/.ssh/nvidia-module-private.key -outform DER -out ~/.ssh/nvidia-module-public.key -nodes -days 3650 -subj "/CN=nvidia-kernel-module"
sudo mokutil --import ~/.ssh/nvidia-module-public.key
reboot

wget https://us.download.nvidia.com/XFree86/Linux-x86_64/555.58/NVIDIA-Linux-x86_64-555.58.run
chmod +x NVIDIA-Linux-x86_64-555.58.run 

sudo apt install pkg-config libglvnd-dev nvidia-prime nvidia-settings

sudo ./NVIDIA-Linux-x86_64-555.58.run \
  --module-signing-secret-key=/home/liviu/.ssh/nvidia-module-private.key \
  --module-signing-public-key=/home/liviu/.ssh/nvidia-module-public.key


sudo ./NVIDIA-Linux-x86_64-555.58.run \
  --ui=none \
  --no-questions \
  --accept-license \
  --no-cc-version-check \
  --no-nouveau-check \
  --install-libglvnd \
  --module-signing-secret-key=/home/liviu/.ssh/nvidia-module-private.key \
  --module-signing-public-key=/home/liviu/.ssh/nvidia-module-public.key

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
