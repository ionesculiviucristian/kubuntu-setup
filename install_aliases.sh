#!/bin/bash

set -eu

cp ./.bash_aliases ~/.bash_aliases;
if [ -f ./.bash_private ]; then
    cp ./.bash_private ~/.bash_private;
fi
