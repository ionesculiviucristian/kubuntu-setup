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
dcl() {
    docker compose logs --follow --tail 100 "$@"
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
dcr() {
    docker compose restart "$@"
}
dcrl() {
    docker compose restart "$@" && docker compose logs --follow --tail 100 "$@"
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
alias update="sudo apt update && sudo apt upgrade"
alias video='glxinfo | grep -E "OpenGL vendor|OpenGL renderer"'
# Some things are best kept private
if [ -f ~/.bash_private ]; then
    . ~/.bash_private
fi
