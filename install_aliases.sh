#!/bin/bash

set -eu

cp ./dotfiles/.bash_aliases ~/.bash_aliases;
if [ -f ./.bash_private ]; then
    cp ./dotfiles/.bash_private ~/.bash_private;
fi
