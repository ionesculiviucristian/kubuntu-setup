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
