#!/bin/bash

# return errors
set -e

# check if ansible is installed
if ! [ -x "$(command -v ansible)" ]; then
    # install ansible
    echo "Installing Ansible..."
    sudo pacman -S ansible --noconfirm
fi
