#!/bin/bash

set -eu

# Generic uninstall
sudo apt purge nvidia*
sudo apot autoremove

# Manual uninstall
# sudo ~/.drivers/NVIDIA-Linux-x86_64-555.58.02.run --uninstall
