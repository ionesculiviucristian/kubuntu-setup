RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# ======================================
# System overrides
# ======================================

alias df="df --print-type --human-readable --all --total"
alias du="du --all --total --human-readable | sort --human-numeric-sort"
alias free="free --mebi --total"
alias ll="ls -l --all --human-readable"
alias mkdir="mkdir --parents"
alias ps="ps auxf"
alias rm="rm --interactive=always"

# ======================================
# File system
# ======================================

# @info Go up a directory level
# @group files
alias ..="cd ../"

# @info Go up two directory levels
# @group files
alias ...="cd ../../"

# @info Go up three directory levels
# @group files
alias ....="cd ../../../"

# @info Go up four directory levels
# @group files
alias .....="cd ../../../../"

# @info Go up a directory level
# @group files
alias .1="cd ../"

# @info Go up two directory levels
# @group files
alias .2="cd ../../"

# @info Go up three directory levels
# @group files
alias .3="cd ../../../"

# @info Go up four directory levels
# @group files
alias .4="cd ../../../../"

# @info List information about the FILEs
# @group files
alias lll="ls -l --all --human-readable | less"

# ======================================
# apt package manager
# ======================================

# @info Install packages
# @group apt
# @param <PACKAGE...>
function apti() {
    sudo apt install "$@"
}

# @info Remove packages
# @group apt
# @param <PACKAGE...>
function aptr() {
    sudo apt purge "$@"
    sudo apt autoremove
}

# @info Upgrade the system by installing/upgrading packages
# @group apt
alias aptu="sudo apt update && sudo apt upgrade"

# ======================================
# Docker
# ======================================

# @info Define and run multi-container applications with Docker
# @group docker
alias dc="docker compose"

# @info Execute a command in a running container
# @group docker
# @param <CONTAINER>
# @param [COMMAND] {sh}
function de() {
    docker exec -it "$1" sh -c "${2:-sh}"
}

# @info Execute a command in a running container, as root
# @group docker
# @param <CONTAINER>
# @param [COMMAND] {sh}
function der() {
    docker exec -it --user root "$1" sh -c "${2:-sh}"
}

# @info Return low-level information on Docker objects
# @group docker
# @param <NAME|ID>
function di() {
    docker inspect "$1"
}

# @info Fetch the logs of a container
# @group docker
# @param <CONTAINER>
function dl() {
    docker logs --follow "$1"
}

# @info Empty log files from all containers
# @group docker
alias dlclr='docker ps -aq | xargs --replace={} sh -c "sudo truncate --size=0 \$(docker inspect --format=\"{{.LogPath}}\" {})"'

# @info List all container log files ordered by their size
# @group docker
alias dlsz='sudo du -ch $(docker inspect --format="{{.LogPath}}" $(docker ps --all --quiet)) | sort -h'

# @info List running containers
# @group docker
alias dps="docker ps"

# @info List all containers
# @group docker
alias dpsa="docker ps --all"

# @info Filter running containers list using grep pattern
# @group docker
# @param <PATTERN>
function dpsf() {
    docker ps | grep "$1"
}

# @info Filter all containers list using grep pattern
# @group docker
# @param <PATTERN>
function dpsaf() {
    docker ps --all | grep "$1"
}

# @info Stop one or more running containers
# @group docker
# @param <CONTAINER...>
function ds() {
    docker stop "$@"
}

# @info Stop all running containers
# @group docker
alias dsa='docker stop $(docker ps --all --quiet)'

# @info Display a live stream of running containers resource usage statistics
# @group docker
alias dsts="docker stats"

# ======================================
# Docker compose
# ======================================

# @info Build or rebuild services
# @group docker_compose
# @param <SERVICE...>
function dcb() {
    docker compose build "$@"
}

# @info Stop and remove containers, networks
# @group docker_compose
# @param <SERVICE...>
function dcd() {
    docker compose down --remove-orphans "$@"
}

# @info Stop and remove containers, networks including volumes
# @group docker_compose
# @param <SERVICE...>
function dcdv() {
    docker compose down --remove-orphans --volumes "$@"
}

# @info Execute a command in a running container
# @group docker_compose
# @param <SERVICE>
# @param [COMMAND] {sh}
function dce() {
    docker compose exec "$1" sh -c "${2:-sh}"
}

# @info Execute a command in a running container, as root
# @group docker_compose
# @param <SERVICE>
# @param [COMMAND] {sh}
function dcer() {
    docker compose exec --user root "$1" sh -c "${2:-sh}"
}

# @info Return low-level information on Docker objects
# @group docker_compose
# @param <SERVICE>
function dci() {
    docker inspect $(docker compose ps --quiet "$1")
}

# @info View output from containers
# @group docker_compose
# @param <SERVICE...>
function dcl() {
    docker compose logs --follow --tail 1000 "$@"
}

# @info List containers
# @group docker_compose
# @param <SERVICE...>
function dcps() {
    docker compose ps --format "table {{.ID}}\t{{.Name}}\t{{.Service}}\t{{.State}}\t{{.Status}}\t{{.Ports}}" "$@"
}

# @info Filter running containers list using grep pattern
# @group docker_compose
# @param <SERVICE>
function dcpsf() {
    docker compose ps --format "table {{.ID}}\t{{.Name}}\t{{.Service}}\t{{.State}}\t{{.Status}}\t{{.Ports}}" | grep "$1"
}

# @info Restart service containers
# @group docker_compose
# @param <SERVICE...>
function dcr() {
    docker compose restart "$@"
}

# @info Restart service containers and view output from containers
# @group docker_compose
# @param <SERVICE...>
function dcrl() {
    docker compose restart "$@" && docker compose logs --follow --tail 1000 "$@"
}

# @info Create and start containers
# @group docker_compose
# @param <SERVICE...>
function dcu() {
    docker compose up --detach "$@"
}

# @info Build, create and start containers
# @group docker_compose
# @param <SERVICE...>
function dcub() {
    docker compose up --detach --build "$@"
}

# @info Recreate and start containers even if their configuration and image haven't changed
# @group docker_compose
# @param <SERVICE...>
function dcuf() {
    docker compose up --detach --force-recreate "$@"
}

# @info Create, start and view output from containers
# @group docker_compose
# @param <SERVICE...>
function dcul() {
    docker compose up --detach "$@" && docker compose logs --follow --tail 1000 "$@"
}

# ======================================
# git
# ======================================

# @info List branches
# @group git
alias gib="git branch"

# @info Create branch
# @group git
# @param <NAME>
function gibc() {
    git branch "$1"
}

# @info Create and checkout branch
# @group git
# @param <NAME>
function gibco() {
    git checkout -b "$1"
}

# @info Delete merged branch
# @group git
# @param <NAME>
function gibd() {
    git branch -d "$1"
}

# @info Delete non-merged branch
# @group git
# @param <NAME>
function gibdf() {
    git branch -D "$1"
}

# @info Rename branch
# @group git
# @param <OLD>
# @param <NEW>
function gibr() {
    git branch -m "$1" "$2"
}

# @info Stage and commit all files from current directory
# @group git
# @param <MESSAGE>
function gic() {
    git add . && git commit -m "$1"
}

# @info Ammend commit
# @group git
# @param <MESSAGE>
function gica() {
    git commit --amend -m "$1"
}

# @info Stage, commit and push all files from current directory
# @group git
# @param <MESSAGE>
function gicpu() {
    git add . && git commit -m "$1" && git push
}

# @info Stage, commit and force push with lease all files from current directory
# @group git
# @param <MESSAGE>
function gicpuf() {
    git add . && git commit -m "$1" && git push --force-with-lease
}

# @info Checkout branch
# @group git
# @param <NAME>
function gico() {
    git checkout "$1"
}

# @info Download objects and refs from another repository
# @group git
alias gif="git fetch"

# @info Show commit logs
# @group git
alias gil='git log --graph --pretty=format:"%C(cyan)%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(magenta)<%an>%Creset" --abbrev-commit --date=relative'

# @info Fetch from and integrate with another repository or a local branch
# @group git
alias gip="git pull"

# @info Fetch from and integrate with another repository or a local branch using rebase
# @group git
alias gipr="git pull --rebase"

# @info Update remote refs along with associated objects
# @group git
alias gipu="git push"

# @info Force update with lease remote refs along with associated objects
# @group git
alias gipuf="git push --force-with-lease"

# @info Hard reset current HEAD to the specified state
# @group git
# @param <SHA1>
function girh() {
    if [ -z "$1" ]; then
        git reset --hard
    else
        git reset --hard "$1"
    fi
}

# @info Squash commits
# @group git
# @param <SHA1>
# @param <MESSAGE>
function gisq() {
    git reset --soft "$1"
    git commit -m "$2"
}

# @info Stash the changes in a dirty working directory away
# @group git
alias gis="git stash"

# ======================================
# poetry
# ======================================

# @info Install project dependencies
# @group poetry
alias poi="poetry install"

# @info Spawn a shell within the virtual environment
# @group poetry
alias pos="poetry shell"

# ======================================
# Misc
# ======================================

# @info Backup files from current directory to \`~/.backups\`
# @group misc
alias backup='zip "$HOME/.backups/$(basename "$PWD" | tr "[:upper:]" "[:lower:]" | tr " " "-")-$(date +%Y%m%d%H%M%S).zip" -r .'

# @info Tail all journal entries
# @group misc
alias logs="sudo journalctl --all --follow"

# @info View all journal entries since last boot
# @group misc
alias logsb="sudo journalctl --boot=-1 --all"

# @info List ports
# @group misc
alias ports="netstat --tcp --udp --listening --all --numeric --programs"

# @info Set the current working directory to \`~/Projects\`
# @group misc
alias proj="cd ${HOME}/Projects"

# @info Create a new project in \`~/Projects\`
# @group misc
# @param <NAME>
function projc() {
    mkdir -p "${HOME}/Projects/$1"
    cd "${HOME}/Projects/$1"
    git init
}

function _autocomplete_projects() {
    local cur;
    local base="${HOME}/Projects"
    _get_comp_words_by_ref cur;
    cur="$base$cur"
    _filedir
    COMPREPLY=("${COMPREPLY[@]#$base}")
}

complete -o nospace -F _autocomplete_projects projo

# @info Open a project found in \`~/Projects\` with code editor
# @group misc
# @param <NAME>
function projo() {
    code "${HOME}/Projects/$1/"
}

# @info Source \`~/.bashrc\`
# @group misc
alias rld="source ${HOME}/.bashrc"

# @info List services
# @group misc
alias srv="systemctl list-units --type=service"

. ~/.bash_aliases_help

# Some things are best kept private
if [ -f ~/.bash_private ]; then
    . ~/.bash_private
fi
