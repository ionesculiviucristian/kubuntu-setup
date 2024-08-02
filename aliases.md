# Aliases

## File system

- `..`: Go up a directory level
- `...`: Go up two directory levels
- `....`: Go up three directory levels
- `.....`: Go up four directory levels
- `.1`: Go up a directory level
- `.2`: Go up two directory levels
- `.3`: Go up three directory levels
- `.4`: Go up four directory levels
- `lll`: List information about the FILEs

## apt package manager

- `apti <PACKAGE...>`: Install packages
- `aptr <PACKAGE...>`: Remove packages
- `aptu`: Upgrade the system by installing/upgrading packages

## Docker

- `dc`: Define and run multi-container applications with Docker
- `de <CONTAINER> [COMMAND] {sh}`: Execute a command in a running container
- `der <CONTAINER> [COMMAND] {sh}`: Execute a command in a running container, as root
- `di <NAME|ID>`: Return low-level information on Docker objects
- `dl <CONTAINER>`: Fetch the logs of a container
- `dlclr`: Empty log files from all containers
- `dlsz`: List all container log files ordered by their size
- `dps`: List running containers
- `dpsa`: List all containers
- `dpsaf <PATTERN>`: Filter all containers list using grep pattern
- `dpsf <PATTERN>`: Filter running containers list using grep pattern
- `ds <CONTAINER...>`: Stop one or more running containers
- `dsa`: Stop all running containers
- `dsts`: Display a live stream of running containers resource usage statistics

## Docker compose

- `dcb <SERVICE...>`: Build or rebuild services
- `dcd <SERVICE...>`: Stop and remove containers, networks
- `dcdv <SERVICE...>`: Stop and remove containers, networks including volumes
- `dce <SERVICE> [COMMAND] {sh}`: Execute a command in a running container
- `dcer <SERVICE> [COMMAND] {sh}`: Execute a command in a running container, as root
- `dci <SERVICE>`: Return low-level information on Docker objects
- `dcl <SERVICE...>`: View output from containers
- `dcps <SERVICE...>`: List containers
- `dcpsf <SERVICE>`: Filter running containers list using grep pattern
- `dcr <SERVICE...>`: Restart service containers
- `dcrl <SERVICE...>`: Restart service containers and view output from containers
- `dcu <SERVICE...>`: Create and start containers
- `dcub <SERVICE...>`: Build, create and start containers
- `dcuf <SERVICE...>`: Recreate and start containers even if their configuration and image haven't changed
- `dcul <SERVICE...>`: Create, start and view output from containers

## git

- `gib`: List branches
- `gibc <NAME>`: Create branch
- `gibco <NAME>`: Create and checkout branch
- `gibd <NAME>`: Delete merged branch
- `gibdf <NAME>`: Delete non-merged branch
- `gibr <OLD> <NEW>`: Rename branch
- `gic <MESSAGE>`: Stage and commit all files from current directory
- `gica <MESSAGE>`: Ammend commit
- `gico <NAME>`: Checkout branch
- `gicpu <MESSAGE>`: Stage, commit and push all files from current directory
- `gicpuf <MESSAGE>`: Stage, commit and force push with lease all files from current directory
- `gif`: Download objects and refs from another repository
- `gil`: Show commit logs
- `gip`: Fetch from and integrate with another repository or a local branch
- `gipr`: Fetch from and integrate with another repository or a local branch using rebase
- `gipu`: Update remote refs along with associated objects
- `gipuf`: Force update with lease remote refs along with associated objects
- `girh <SHA1>`: Hard reset current HEAD to the specified state
- `gis`: Stash the changes in a dirty working directory away
- `gisq <SHA1> <MESSAGE>`: Squash commits

## poetry

- `poi`: Install project dependencies
- `pos`: Spawn a shell within the virtual environment

## Misc

- `backup`: Backup files from current directory to `~/.backups`
- `logs`: Tail all journal entries
- `logsb`: View all journal entries since last boot
- `ports`: List ports
- `proj`: Set the current working directory to `~/Projects`
- `projc <NAME>`: Create a new project in `~/Projects`
- `projo <NAME>`: Open a project found in `~/Projects` with code editor
- `rld`: Source `~/.bashrc`
- `srv`: List services
