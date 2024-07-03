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
alias dcps='docker compose ps --format "table {{.ID}}\t{{.Name}}\t{{.Service}}\t{{.State}}\t{{.Status}}\t{{.Ports}}"'
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
# Misc
alias path="echo -e ${PATH//:/\\n}"
alias ports="netstat -tulanp"
alias update="sudo apt update && sudo apt upgrade"
# Some things are best kept private
if [ -f ~/.bash_private ]; then
    . ~/.bash_private
fi
