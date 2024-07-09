RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
# Overrides
alias ll="ls -ahl"
alias mkdir="mkdir -pv"
alias rm='rm -i'
# Fix of the century
alias cd..="cd .."
# Navigation
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias .1="cd ../"
alias .2="cd ../../"
alias .3="cd ../../../"
alias .4="cd ../../../../"
alias .5="cd ../../../../../"
# apt
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
alias dps="docker ps"
dpsg() {
    docker ps | grep "$1"
}
alias ds="docker stats"
alias dsa='docker stop $(docker ps -aq)'
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
    docker compose exec "$1" sh
}
dcer() {
    docker compose exec --user root "$1" sh
}
dci() {
    docker inspect $(docker compose ps -q "$@")
}
dcl() {
    docker compose logs --follow --tail 1000 "$@"
}
dclc() {
    for container_id in $(docker ps -aq); do
        log_path=$(docker inspect --format='{{.LogPath}}' $container_id)
        sudo truncate -s 0 $log_path
        echo "Cleared ${log_path} for ${container_id}"
    done
}
dcps() {
    docker compose ps --format "table {{.ID}}\t{{.Name}}\t{{.Service}}\t{{.State}}\t{{.Status}}\t{{.Ports}}" "$@"
}
dcpsg() {
    dcps | grep "$1"
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
gichk() {
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
alias err="sudo journalctl -b -1 -a"
info() {
    echo -e "${GREEN}Operating system:${NC}"
    lsb_release -a
    echo -e "${GREEN}Kernel:${NC}"
    uname -a
    echo -e "${GREEN}OpenGL:${NC}"
    glxinfo | grep -E "OpenGL vendor|OpenGL renderer|OpenGL version"
    echo -e "${GREEN}Memory:${NC}"
    free -m -l -t
    echo -e "${GREEN}Disk space:${NC}"
    df -h
    echo -e "${GREEN}Virtualization:${NC}"
    kvm-ok
    echo -e "${GREEN}Environment variables:${NC}"
    printenv
}
alias path="echo -e ${PATH//:/\\n}"
alias ports="netstat -tulanp"
# Some things are best kept private
if [ -f ~/.bash_private ]; then
    . ~/.bash_private
fi
