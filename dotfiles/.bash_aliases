RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
# Fix of the century
alias cd..="cd .."
# Change some defaults
alias ll="ls -ahl"
alias mkdir="mkdir -pv"
# Navigation
alias ..="cd .."
alias ...="cd ../../../"
alias ....="cd ../../../../"
alias .....="cd ../../../../"
alias .4="cd ../../../../"
alias .5="cd ../../../../.."
# apt
alias aptu="sudo apt update && sudo apt upgrade"
apti() {
    sudo apt install "$@"
}
aptr() {
    sudo apt purge "$@"
    sudo apt autoremove
}
# Docker
alias dc="docker compose"
alias dps="docker ps"
alias ds="docker stats --no-stream"
alias dsa='docker stop $(docker ps -a -q)'
di() {
    docker inspect "$1"
}
dpsg() {
    docker ps | grep "$1"
}
# Docker compose
dcps() {
    docker compose ps --format "table {{.ID}}\t{{.Name}}\t{{.Service}}\t{{.State}}\t{{.Status}}\t{{.Ports}}" "$@"
}
dcpsg() {
    dcps | grep "$1"
}
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
dcpsg() {
    dcps | grep "$1"
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
dcr() {
    docker compose restart "$@"
}
dcrl() {
    docker compose restart "$@" && docker compose logs --follow --tail 1000 "$@"
}
# Git
alias gf="git fetch"
alias gp="git pull"
alias gpu="git push"
alias gpuf="git push --force-with-lease"
alias gs="git stash"
gc() {
    git add . && git commit -m "$1"
}
gchk() {
    git checkout "$1"
}
# Misc
alias path="echo -e ${PATH//:/\\n}"
alias ports="netstat -tulanp"
info() {
    echo -e "${GREEN}OS:${NC}"
    lsb_release -a
    echo -e "${GREEN}Kernel:${NC}"
    uname -a
    echo -e "${GREEN}Video:${NC}"
    glxinfo | grep -E "OpenGL vendor|OpenGL renderer|OpenGL version"
    echo -e "${GREEN}Virtualization:${NC}"
    kvm-ok
}
# Some things are best kept private
if [ -f ~/.bash_private ]; then
    . ~/.bash_private
fi
