#!/bin/bash

set -eu

install_deb() {
  DEB_INSTALLER=$(mktemp)
  wget "$1" -O ${DEB_INSTALLER}
  sudo apt install -y ${DEB_INSTALLER}
  rm ${DEB_INSTALLER}
}

sudo add-apt-repository ppa:rvm/smplayer 

sudo apt update

# Install drivers
sudo ubuntu-drivers autoinstall

# Install packages
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
  net-tools \
  smplayer smplayer-themes \
  transmission \
  tree \
  virtualbox \
  wkhtmltopdf

sudo snap install \
  postman \
  mysql-workbench-community

snap connect mysql-workbench-community:password-manager-service 
snap connect mysql-workbench-community:ssh-keys

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

# Setup bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Setup git
git config --global user.name "Ionescu Liviu Cristian"
git config --global user.email "$(echo bGl2aXVAcHVycGxlY2F0LWxhYnMuY29t | base64 --decode)"
git config --global init.defaultBranch main
git config --global core.editor "code --wait --new-window"
git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'

# Setup python
sudo ln -s /usr/bin/python3 /usr/bin/python

# Install python tools (pipx, poetry)
sudo apt update
sudo apt install -y pipx
pipx ensurepath
pipx install poetry

# HARDINFO2
# https://github.com/hardinfo2/hardinfo2
install_deb https://github.com/hardinfo2/hardinfo2/releases/download/release-2.1.10pre/hardinfo2_2.1.10-Ubuntu-24.04_amd64.deb

# Google Chrome
install_deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# nvm (Node Version Manager)
# https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 18
nvm install 20
nvm install 22

nvm alias default 20

nvm install-latest-npm
npm install -g npm-check-updates

# VSCode
# https://code.visualstudio.com/docs/setup/linux
install_deb https://go.microsoft.com/fwlink/?LinkID=760868

# Docker
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update && sudo apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world

sudo usermod -aG docker $USER

# NVIDIA Container Toolkit
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit

sudo nvidia-ctk runtime configure --runtime=docker

# Install dotfiles
guake --restore-preferences ./dotfiles/guake

# Install aliases
./install_aliases.sh

sudo reboot now
