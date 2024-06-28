#!/bin/bash

set -eu

# Install system tools / apps
sudo apt update;
sudo apt install -y \
    apache2-utils \
    btop \
    build-essential \
    ca-certificates \
    curl \
    dconf-cli \
    guake \
    jose \
    keepassxc \
    libnss3-tools \
    net-tools \
    virtualbox \
    wkhtmltopdf;

# Setup directories
mkdir ~/.local/share/fonts;
mkdir ~/.repos;
mkdir ~/Projects;

# Install fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz -O ~/.local/share/fonts/JetBrainsMono.tar.xz;
tar -xf ~/.local/share/fonts/JetBrainsMono.tar.xz -C ~/.local/share/fonts;
rm ~/.local/share/fonts/JetBrainsMono.tar.xz;
fc-cache -f -v;

# Install python tools (pipx, poetry)
sudo apt update;
sudo apt install -y pipx;
pipx ensurepath;
pipx install poetry;

# nvm (Node Version Manager)
# https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash;
export NVM_DIR="$HOME/.nvm";
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh";
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion";
nvm install 18;
nvm install-latest-npm;

# Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb;
sudo apt install -y /tmp/chrome.deb;
rm /tmp/chrome.deb;

# VSCode
# https://code.visualstudio.com/docs/setup/linux
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O /tmp/code.deb;
sudo apt install -y /tmp/code.deb;
rm /tmp/code.deb;

# Docker
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
sudo install -m 0755 -d /etc/apt/keyrings;
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc;
sudo chmod a+r /etc/apt/keyrings/docker.asc;

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
sudo apt-get update;

sudo apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin;

sudo docker run hello-world;

sudo usermod -aG docker $USER;

# Install normal drivers
# sudo apt install nvidia-driver-535;

# Or install CUDA enabled drivers with NVIDIA Container Toolkit
# wget https://developer.download.nvidia.com/compute/cuda/12.5.0/local_installers/cuda_12.5.0_555.42.02_linux.run
# chmod +x cuda_12.5.0_555.42.02_linux.run
# sudo ./cuda_12.5.0_555.42.02_linux.run --silent --driver --toolkit --override
# rm -f cuda_12.5.0_555.42.02_linux.run
# echo 'export PATH="/usr/local/cuda/bin:$PATH"' >> ~/.bashrc
# echo 'export LD_LIBRARY_PATH="/usr/local/cuda-12.5/lib64"' >> ~/.bashrc

# curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
#   && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
#     sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
#     sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
# sudo apt-get update
# sudo apt-get install -y nvidia-container-toolkit

# sudo nvidia-ctk runtime configure --runtime=docker
# sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi

echo "blacklist i2c_nvidia_gpu" | sudo tee -a /etc/modprobe.d/blacklist_i2c-nvidia-gpu.conf;
sudo update-initramfs -u;

sudo mkdir /etc/systemd/system/bluetooth.service.d;
echo -e "[Service]\nExecStart=\nExecStart=/usr/libexec/bluetooth/bluetoothd --noplugin=sap" | sudo tee -a /etc/systemd/system/bluetooth.service.d/01-disable-sap-plugin.conf;
sudo systemctl daemon-reload;
sudo systemctl restart bluetooth.service;

# Setup dotfiles
./install_aliases.sh
guake --restore-preferences ./dotfiles/guake

sudo reboot now;
