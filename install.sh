#!/bin/bash

set -eu

# Install system tools / apps
sudo apt update
sudo apt install -y \
    apache2-utils \
    bat \
    btop \
    build-essential \
    ca-certificates \
    cpu-checker \
    curl \
    dconf-cli \
    guake \
    jose \
    keepassxc \
    libnss3-tools \
    mesa-utils \
    net-tools \
    tree \
    virtualbox \
    wkhtmltopdf

# Invoke bat easier
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Setup directories
mkdir ~/.backups
mkdir ~/.drivers
mkdir -p ~/.local/share/fonts
mkdir ~/.repos
mkdir ~/Projects

# Install fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz -O ~/.local/share/fonts/JetBrainsMono.tar.xz
tar -xf ~/.local/share/fonts/JetBrainsMono.tar.xz -C ~/.local/share/fonts
rm ~/.local/share/fonts/JetBrainsMono.tar.xz
fc-cache -f -v

# Install python tools (pipx, poetry)
sudo apt update
sudo apt install -y pipx
pipx ensurepath
pipx install poetry

# nvm (Node Version Manager)
# https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 18
nvm install 20
nvm install 22
nvm install-latest-npm

# Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb
sudo apt install -y /tmp/chrome.deb
rm /tmp/chrome.deb

# VSCode
# https://code.visualstudio.com/docs/setup/linux
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O /tmp/code.deb
sudo apt install -y /tmp/code.deb
rm /tmp/code.deb

# Docker
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world

sudo usermod -aG docker $USER

git config --global user.name "Ionescu Liviu Cristian"
git config --global user.email "$(echo bGl2aXVAcHVycGxlY2F0LWxhYnMuY29t | base64 --decode)"
git config --global init.defaultBranch main

sudo snap install postman

# Setup dotfiles
./install_aliases.sh
guake --restore-preferences ./dotfiles/guake

sudo reboot now
