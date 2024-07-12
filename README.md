# Kubuntu 24.04 setup

### Installed packages

- [apache2-utils](https://packages.ubuntu.com/noble/apache2-utils): Apache HTTP Server (utility programs for web servers)
- [bat](https://github.com/sharkdp/bat): A cat(1) clone with syntax highlighting and Git integration
- [btop](https://github.com/aristocratos/btop): Resource monitor that shows usage and stats for processor, memory, disks, network and processes
- [build-essential](https://packages.ubuntu.com/focal/build-essential): The build-essentials packages are the form of meta-packages that are essential to compile software. They contain the GNU/g++ compiler collection, GNU debugger, and a few more libraries and tools that are needed for compiling a program
- [ca-certificates](https://packages.ubuntu.com/noble/ca-certificates): Common CA certificates
- [cpu-checker](https://packages.ubuntu.com/noble/cpu-checker): tools to help evaluate certain CPU (or BIOS) features
- [Chrome](https://www.google.com/chrome/): Chrome is the official web browser from Google, built to be fast, secure, and customizable
- [curl](https://github.com/curl/curl): A command line tool and library for transferring data with URL syntax, supporting DICT, FILE, FTP, FTPS, GOPHER, GOPHERS, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, MQTT, POP3, POP3S, RTMP, RTMPS, RTSP, SCP, SFTP, SMB, SMBS, SMTP, SMTPS, TELNET, TFTP, WS and WSS. libcurl offers a myriad of powerful features
- [dconf-cli](https://packages.ubuntu.com/noble/dconf-cli): simple configuration storage system - utilities
- [Docker](https://www.docker.com/): Docker is a platform designed to help developers build, share, and run container applications
- [guake](https://github.com/Guake/guake): Drop-down terminal for GNOME
- [jose](https://github.com/panva/jose): JWA, JWS, JWE, JWT, JWK, JWKS for Node.js, Browser, Cloudflare Workers, Deno, Bun, and other Web-interoperable runtimes
- [keepassxc](https://github.com/keepassxreboot/keepassxc): KeePassXC is a cross-platform community-driven port of the Windows application “Keepass Password Safe”
- [libnss3-tools](https://packages.ubuntu.com/focal/libnss3-tools): Network Security Service tools
- [mesa-utils](https://packages.ubuntu.com/noble/mesa-utils): Miscellaneous Mesa utilities -- symlinks
- [net-tools](https://github.com/ecki/net-tools): Linux base networking tools
- [nvm](https://github.com/nvm-sh/nvm): Node Version Manager - POSIX-compliant bash script to manage multiple active node.js versions
- [pipx](https://github.com/pypa/pipx): Install and Run Python Applications in Isolated Environments
- [Postman](https://www.postman.com/): Postman is an API platform for building and using APIs. Postman simplifies each step of the API lifecycle and streamlines collaboration so you can create better APIs—faster
- [tree](https://oldmanprogrammer.net/source.php?dir=projects/tree): This is a handy little utility to display a tree view of directories with added color support
- [virtualbox](https://www.virtualbox.org/): VirtualBox is a powerful x86 and AMD64/Intel64 virtualization product for enterprise as well as home use
- [Visual Studio Code](https://code.visualstudio.com/): Visual Studio Code is a code editor redefined and optimized for building and debugging modern web and cloud applications
- [wkhtmltopdf](https://wkhtmltopdf.org/): wkhtmltopdf and wkhtmltoimage are open source (LGPLv3) command line tools to render HTML into PDF and various image formats using the Qt WebKit rendering engine

### Available aliases

#### File system

- `..` or `.1`: Go up a directory level
- `...` or `.2`: Go up two directory levels
- `....` or `.3`: Go up three directory levels
- `.....` or `.4`: Go up four directory levels

#### apt package manager

- `apti <package(s)>`: Install packages
- `aptr <package(s)>`: Remove packages and automatically remove all unused packages
- `aptu`: Upgrade the system by installing/upgrading packages

#### Docker

- `dc`: Define and run multi-container applications with Docker
- `di <container>`: Return low-level information on Docker objects
- `dlclr`: Empty logs from all containers
- `dlsz`: Order list of logs from all containers by their size; also print their total size
- `dps`: List running containers
- `dpsa`: List all containers
- `dpsf <query>`: Search in running containers list
- `dpsaf <query>`: Search in all containers list
- `dsts`: Display a live stream of container(s) resource usage statistics
- `ds <container(s)>`: Stop one or more running containers
- `dsa`: Stop all running containers

#### Docker compose

- `dcb <service(s)>`: Build or rebuild services
- `dcd <service(s)>`: Stop and remove containers, networks
- `dcdv <service(s)>`: Stop and remove containers, networks including volumes
- `dce <command>`: Execute a command in a running container
- `dcer`: Execute a command in a running container as root
- `dci <service>`: Return low-level information on Docker objects
- `dcl <service(s)>`: View output from containers
- `dcps <service(s)>`: List containers
- `dcpsf <service>`: Search in containers list
- `dcr <service(s)>`: Restart service containers
- `dcrl <service(s)>`: Restart service containers and view output from containers
- `dcu <service(s)>`: Create and start containers
- `dcub <service(s)>`: Build, create and start containers
- `dcuf <service(s)>`: Recreate and start containers even if their configuration and image haven't changed
- `dcul <service(s)>`: Create, start and view output from containers

#### git

- `gic`: Add file contents to the index from the current directory and record changes to the repository
- `gico`: Switch branches or restore working tree files
- `gif`: Download objects and refs from another repository
- `gil`: Shows the commit logs
- `gip`: Fetch from and integrate with another repository or a local branch
- `gipu`: Update remote refs along with associated objects
- `gipuf`: Update remote refs along with associated objects using `--force-with-lease`
- `girh <commit>`: Hard reset current HEAD to the specified state
- `gisq <commit> <message>`: Squash commits
- `gis`: Stash the changes in a dirty working directory away

#### poetry

- `poi`: Installs the project dependencies
- `pos`: Spawns a shell within the virtual environment

#### Misc

- `backup`: Backup files from current directory to `~/.backups`
- `info`: Get an overview on the current operating system
- `jrn`: Query the journal continuously
- `jrna`: Query the journal for all logs from the previous boot
- `ports`: List ports
- `proj`: Switch the current working directory to `~/Projects`
- `projc <name>`: Create a new project in `~/Projects`
- `rld`: Source `~/.bashrc`
- `srv`: List service units currently in memory

### Additional notes

- bash will use `~/.bash_private`, if present

### Drivers and hardware tools

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
