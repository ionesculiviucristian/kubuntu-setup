#!/bin/bash

set -eu

# Install packages
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
    transmission \
    tree \
    virtualbox \
    wkhtmltopdf

sudo snap install postman

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

nvm use 20
nvm install-latest-npm
npm install -g npm-check-updates

# Google Chrome
GOOGLE_CHROME_DEB=$(mktemp)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ${GOOGLE_CHROME_DEB}
sudo apt install -y ${GOOGLE_CHROME_DEB}
rm ${GOOGLE_CHROME_DEB}

# VSCode
# https://code.visualstudio.com/docs/setup/linux
CODE_DEB=$(mktemp)
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O ${CODE_DEB}
sudo apt install -y ${CODE_DEB}
rm ${CODE_DEB}

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

# GitHub Desktop
# https://github.com/apps/desktop
wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
sudo apt update && sudo apt install github-desktop

# Install dotfiles
./install_aliases.sh
guake --restore-preferences ./dotfiles/guake

# Apply settings
git config --global user.name "Ionescu Liviu Cristian"
git config --global user.email "$(echo bGl2aXVAcHVycGxlY2F0LWxhYnMuY29t | base64 --decode)"
git config --global init.defaultBranch main

sudo ln -s /usr/bin/python3 /usr/bin/python

sudo reboot now
