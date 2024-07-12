#### Install NVIDIA drivers

```bash
# This step is required only if you have SecureBoot enabled
openssl req -new -x509 -newkey rsa:4096 -keyout ~/.ssh/nvidia-module-private.key -outform DER -out ~/.ssh/nvidia-module-public.key -nodes -days 3650 -subj "/CN=nvidia-kernel-module"

sudo mokutil --import ~/.ssh/nvidia-module-public.key

# Download driver
wget -P ~/.drivers https://us.download.nvidia.com/XFree86/Linux-x86_64/550.100/NVIDIA-Linux-x86_64-550.100.run
chmod +x ~/.drivers/NVIDIA-Linux-x86_64-550.100.run

# Disable nouveau driver
cat <<EOF | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
blacklist nouveau
options nouveau modeset=0
EOF
sudo update-initramfs -u -k all

reboot

# Install driver using tty
sudo ~/.drivers/NVIDIA-Linux-x86_64-550.100.run \
  --module-signing-secret-key=${HOME}/.ssh/nvidia-module-private.key \
  --module-signing-public-key=${HOME}/.ssh/nvidia-module-public.key

reboot

sudo apt install nvidia-prime
sudo prime-select nvidia

reboot
```

#### Install NVIDIA CUDA

```bash
# Download and install
wget -P ~/.drivers https://developer.download.nvidia.com/compute/cuda/12.5.1/local_installers/cuda_12.5.1_555.42.06_linux.run
chmod +x ~/.drivers/cuda_12.5.1_555.42.06_linux.run
sudo ~/.drivers/cuda_12.5.1_555.42.06_linux.run

echo 'export PATH="/usr/local/cuda/bin:$PATH"' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH="/usr/local/cuda-12.5/lib64"' >> ~/.bashrc

# Test installation
nvcc --version
```

#### Install NVIDIA Container Toolkit

```bash
# Download and install
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# Test a Docker container
sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```
