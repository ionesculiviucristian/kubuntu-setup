RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
# System overrides
alias ll="ls -l --all --human-readable"
alias mkdir="mkdir --parents"
alias rm='rm -i'
# File system
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias .1="cd ../"
alias .2="cd ../../"
alias .3="cd ../../../"
alias .4="cd ../../../../"
# apt package manager
apti() {
    sudo apt install "$@"
}
aptr() {
    sudo apt purge "$@"
    sudo apt autoremove
}
alias aptu="sudo apt update && sudo apt upgrade"
# Docker
alias dc="docker compose"
di() {
    docker inspect "$1"
}
alias dlclr='docker ps -aq | xargs --replace={} sh -c "sudo truncate --size=0 \$(docker inspect --format=\"{{.LogPath}}\" {})"'
alias dlsz='sudo du -ch $(docker inspect --format="{{.LogPath}}" $(docker ps --all --quiet)) | sort -h'
alias dps="docker ps"
alias dpsa="docker ps --all"
dpsf() {
    docker ps | grep "$1"
}
dpsaf() {
    docker ps --all | grep "$1"
}
alias dsts="docker stats"
ds() {
    docker stop "$@"
}
alias dsa='docker stop $(docker ps --all --quiet)'
# Docker compose
dcb() {
    docker compose build "$@"
}
dcd() {
    docker compose down --remove-orphans "$@"
}
dcdv() {
    docker compose down --remove-orphans --volumes "$@"
}
dce() {
    docker compose exec "$1" "${2:-sh}"
}
dcer() {
    docker compose exec --user root "$1" "${2:-sh}"
}
dci() {
    docker inspect $(docker compose ps --quiet "$@")
}
dcl() {
    docker compose logs --follow --tail 1000 "$@"
}
dcps() {
    docker compose ps --format "table {{.ID}}\t{{.Name}}\t{{.Service}}\t{{.State}}\t{{.Status}}\t{{.Ports}}" "$@"
}
dcpsf() {
    docker compose ps --format "table {{.ID}}\t{{.Name}}\t{{.Service}}\t{{.State}}\t{{.Status}}\t{{.Ports}}" "$@" | grep "$1"
}
dcr() {
    docker compose restart "$@"
}
dcrl() {
    docker compose restart "$@" && docker compose logs --follow --tail 1000 "$@"
}
dcu() {
    docker compose up --detach "$@"
}
dcub() {
    docker compose up --detach --build "$@"
}
dcuf() {
    docker compose up --detach --force-recreate "$@"
}
dcul() {
    docker compose up --detach "$@" && docker compose logs --follow --tail 1000 "$@"
}
# git
gic() {
    git add . && git commit -m "$1"
}
gico() {
    git checkout "$1"
}
alias gif="git fetch"
alias gip="git pull"
alias gipr="git pull --rebase"
alias gipu="git push"
alias gipuf="git push --force-with-lease"
alias gis="git stash"
# poetry
alias poi="poetry install"
alias pos="poetry shell"
# Misc
info() {
    echo -e "${GREEN}Operating system:${NC}"
    lsb_release --all
    echo -e "${GREEN}Secure boot:${NC}"
    sudo mokutil --sb-state
    echo -e "${GREEN}Kernel:${NC}"
    uname --all
    echo -e "${GREEN}OpenGL:${NC}"
    glxinfo | grep -E "OpenGL vendor|OpenGL renderer|OpenGL version"
    echo -e "${GREEN}Memory:${NC}"
    free --mebi --lohi --total
    echo -e "${GREEN}Disk space:${NC}"
    df --human-readable
    echo -e "${GREEN}Virtualization:${NC}"
    kvm-ok
    echo -e "${GREEN}Environment variables:${NC}"
    printenv
}
alias jrna="sudo journalctl --boot=-1 --all"
alias path='echo -e ${PATH//:/\\n}'
alias ports="netstat --tcp --udp --listening --all --numeric --programs"
alias prj="cd $HOME/Projects"
alias services="systemctl list-units --type=service"
# Some things are best kept private
if [ -f ~/.bash_private ]; then
    . ~/.bash_private
fi
