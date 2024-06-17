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
alias dsa="docker stop $(docker ps -a -q)"
di() {
    docker inspect "$1"
}
# Docker compose
alias dcd="dc down --remove-orphans"
alias dcdv="dcd -v"
alias dcps='dc ps --format "table {{.ID}}\t{{.Name}}\t{{.Service}}\t{{.State}}\t{{.Status}}\t{{.Ports}}"'
alias dcr="dc restart"
dce () {
    dc exec "$1" sh
}
dcer () {
    dc exec --user root "$1" sh
}
dcl() {
    if [ -n "$1" ]; then
        dc logs -f "$1"
    else
        dc logs -f
    fi
}
dcu() {
    if [ -n "$1" ]; then
        dc up -d "$1"
    else
        dc up -d
    fi
}
dcuf() {
    if [ -n "$1" ]; then
        dcu "$1" --force-recreate
    else
        dcu --force-recreate
    fi
}
# Misc
alias path="echo -e ${PATH//:/\\n}"
alias ports="netstat -tulanp"
alias update="sudo apt update && sudo apt upgrade"
# Some things are best kept private
if [ -f ~/.bash_private ]; then
    . ~/.bash_private
fi
