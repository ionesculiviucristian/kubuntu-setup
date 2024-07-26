#!/bin/bash

set -eu

cp ./dotfiles/.bash_aliases ~/.bash_aliases
cp ./dotfiles/.bash_aliases_help ~/.bash_aliases_help

if [ -f ./dotfiles/.bash_private ]; then
    cp ./dotfiles/.bash_private ~/.bash_private
fi
