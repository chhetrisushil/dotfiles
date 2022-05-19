#!/bin/bash

# return errors
set -e

# some dir path variables
SSH_DIR="$HOME/.ssh"
DOTFILES_DIR="$HOME/dotfiles"

# check if ansible is installed
if ! [ -x "$(command -v ansible)" ]; then
    # install ansible
    echo "Installing Ansible..."
    sudo pacman -S ansible --noconfirm
fi

# check if public key is already in place
if ! [[ -f "$SSH_DIR/id_rsa" ]]; then
    # create ssh dir
    echo "Creating SSH dir..."
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"

    # create ssh key
    echo "Creating SSH key..."
    ssh-keygen -t ed25519 -N "" -C "$USER@$HOSTNAME" -f "$SSH_DIR/id_rsa"

    # copy public key to authorized_keys
    echo "Copying public key to authorized_keys..."
    cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"

    # give user permissions to authorized_keys
    echo "Giving user permissions to authorized_keys..."
    chmod 600 "$SSH_DIR/authorized_keys"
fi
