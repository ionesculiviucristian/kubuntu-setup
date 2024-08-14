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
    sudo apt purge "$@" && sudo apt autoremove
}

# @info Upgrade the system by installing/upgrading packages
# @group apt
alias aptu="sudo apt update && sudo apt upgrade"

# ======================================
# Docker
# ======================================

_complete_containers() {
    local MODE="$1"
    if [[ ${MODE} == "single" ]]; then
        shift
    fi
    if [[ ${MODE} == "single" && ${COMP_CWORD} -ge 2 ]]; then
        COMPREPLY=()
        return 0
    fi
    local CONTAINERS=$(docker ps --format "{{.Names}}")
    COMPREPLY=($(compgen -W "${CONTAINERS}}" -- "$2"))
}

_complete_container() {
    _complete_containers "single" "$@"
}

# @info Execute a command in a running container
# @group docker
# @param <CONTAINER>
# @param [COMMAND] {sh}
function de() {
    docker exec -it "$1" sh -c "${2:-sh}"
}
complete -o nospace -F _complete_container de

# @info Execute a command in a running container, as root
# @group docker
# @param <CONTAINER>
# @param [COMMAND] {sh}
function der() {
    docker exec -it --user root "$1" sh -c "${2:-sh}"
}
complete -o nospace -F _complete_container der

# @info Return low-level information on Docker objects
# @group docker
# @param <NAME|ID>
function di() {
    docker inspect "$1"
}
complete -o nospace -F _complete_container di

# @info Fetch the logs of a container
# @group docker
# @param <CONTAINER>
function dl() {
    docker logs --follow "$1"
}
complete -o nospace -F _complete_container dl

# @info Empty the log files from all containers
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
complete -F _complete_containers ds

# @info Stop all running containers
# @group docker
alias dsa='docker stop $(docker ps --all --quiet)'

# @info Display a live stream of running containers resource usage statistics
# @group docker
alias dsts="docker stats"

# ======================================
# Docker compose
# ======================================

_complete_services() {
    local MODE="$1"
    if [[ ${MODE} == "single" ]]; then
        shift
    fi
    if [[ ${MODE} == "single" && ${COMP_CWORD} -ge 2 ]]; then
        COMPREPLY=()
        return 0
    fi
    local SERVICES=$(docker compose ps --services 2>/dev/null)
    COMPREPLY=($(compgen -W "${SERVICES}" -- "$2"))
}

_complete_service() {
    _complete_services "single" "$@"
}

# @info Define and run multi-container applications with Docker
# @group docker_compose
alias dc="docker compose"

# @info Build or rebuild services
# @group docker_compose
# @param <SERVICE...>
function dcb() {
    docker compose build "$@"
}
complete -F _complete_services dcb

# @info Stop and remove containers, networks
# @group docker_compose
# @param <SERVICE...>
function dcd() {
    docker compose down --remove-orphans "$@"
}
complete -F _complete_services dcd

# @info Stop and remove containers, networks including volumes
# @group docker_compose
# @param <SERVICE...>
function dcdv() {
    docker compose down --remove-orphans --volumes "$@"
}
complete -F _complete_services dcdv

# @info Execute a command in a running container
# @group docker_compose
# @param <SERVICE>
# @param [COMMAND] {sh}
function dce() {
    docker compose exec "$1" sh -c "${2:-sh}"
}
<<<<<<< Updated upstream
complete -o nospace -F _complete_services_single dce
=======
complete -o nospace -F _complete_container dce
>>>>>>> Stashed changes

# @info Execute a command in a running container, as root
# @group docker_compose
# @param <SERVICE>
# @param [COMMAND] {sh}
function dcer() {
    docker compose exec --user root "$1" sh -c "${2:-sh}"
}
<<<<<<< Updated upstream
complete -o nospace -F _complete_services_single dcer
=======
complete -o nospace -F _complete_container dcer
>>>>>>> Stashed changes

# @info Return low-level information on Docker objects
# @group docker_compose
# @param <SERVICE>
function dci() {
    docker inspect $(docker compose ps --quiet "$1")
}
<<<<<<< Updated upstream
complete -o nospace -F _complete_services_single dci
=======
complete -o nospace -F _complete_container dci
>>>>>>> Stashed changes

# @info View output from containers
# @group docker_compose
# @param <SERVICE...>
function dcl() {
    docker compose logs --follow --tail 1000 "$@"
}
complete -F _complete_services dcl

# @info List containers
# @group docker_compose
# @param <SERVICE...>
function dcps() {
    docker compose ps --format "table {{.ID}}\t{{.Name}}\t{{.Service}}\t{{.State}}\t{{.Status}}\t{{.Ports}}" "$@"
}
complete -F _complete_services dcps

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
complete -F _complete_services dcr

# @info Restart service containers and view output from containers
# @group docker_compose
# @param <SERVICE...>
function dcrl() {
    docker compose restart "$@" && docker compose logs --follow --tail 1000 "$@"
}
complete -F _complete_services dcrl

# @info Create and start containers
# @group docker_compose
# @param <SERVICE...>
function dcu() {
    docker compose up --detach "$@"
}
complete -F _complete_services dcu

# @info Build, create and start containers
# @group docker_compose
# @param <SERVICE...>
function dcub() {
    docker compose up --detach --build "$@"
}
complete -F _complete_services dcub

# @info Recreate and start containers even if their configuration and image haven't changed
# @group docker_compose
# @param <SERVICE...>
function dcuf() {
    docker compose up --detach --force-recreate "$@"
}
complete -F _complete_services dcuf

# @info Create, start and view output from containers
# @group docker_compose
# @param <SERVICE...>
function dcul() {
    docker compose up --detach "$@" && docker compose logs --follow --tail 1000 "$@"
}
complete -F _complete_services dcul

# ======================================
# git
# ======================================

_complete_branches() {
    if [[ ${COMP_CWORD} -ge 2 ]]; then
        COMPREPLY=()
        return 0
    fi
    local BRANCHES=$(git branch 2>/dev/null | sed 's/^[* ]*//')
    COMPREPLY=($(compgen -W "${BRANCHES}" -- "$2"))
}

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
# @param <BRANCH>
function gibd() {
    git branch -d "$1"
}
complete -o nospace -F _complete_branches gibd

# @info Delete non-merged branch
# @group git
# @param <BRANCH>
function gibdf() {
    git branch -D "$1"
}
complete -o nospace -F _complete_branches gibdf

# @info Rename branch
# @group git
# @param <OLD BRANCH>
# @param <NEW BRANCH>
function gibr() {
    git branch -m "$1" "$2"
}
complete -o nospace -F _complete_branches gibr

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
# @param <BRANCH>
function gico() {
    git checkout "$1"
}
complete -o nospace -F _complete_branches gico

# @info Download objects and refs from another repository
# @group git
alias gif="git fetch"

# @info Show commit logs
# @group git
alias gil='git log --graph --pretty=format:"%C(cyan)%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(magenta)<%an>%Creset" --abbrev-commit --date=relative'

# @info Join two or more development histories together
# @group git
# @param <BRANCH...>
function gim() {
    git merge "$@"
}
complete -F _complete_branches gim

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

_complete_projects() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=()
    pushd "${HOME}/Projects" >/dev/null
    _filedir -d
    popd >/dev/null
}

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
complete -o nospace -F _complete_projects projo

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
