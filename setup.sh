#!/bin/bash

# return errors
set -e

PREFIX_SUDO=''

# check if user is root
if [ "$(id -u)" != "0" ]; then
    PREFIX_SUDO='sudo'
fi

# some dir path variables
SSH_DIR="$HOME/.ssh"
DOTFILES_DIR="$HOME/.dotfiles"

# check if make is present
if ! [ -x "$(command -v make)" ]; then
    # install make
    $PREFIX_SUDO pacman -S make --noconfirm
fi

# check if binutils is present
if ! [ -x "$(command -v ar)" ]; then
    # install binutils
    $PREFIX_SUDO pacman -S binutils --noconfirm
fi

# check if zsh is installed
if ! [ -x "$(command -v zsh)" ]; then
    #install zsh
    echo "Installing zsh..."
    $PREFIX_SUDO pacman -S zsh --noconfirm
fi

# check if zsh is default shell
if [ "$SHELL" != "$(command -v zsh)" ]; then
    # set zsh as default shell
    echo "Setting zsh as default shell..."
    $PREFIX_SUDO chsh -s $(command -v zsh)
fi

# check if git is present
if ! [ -x "$(command -v git)" ]; then
    # install git
    echo "Installing git..."
    $PREFIX_SUDO pacman -S git --noconfirm
fi

# check if oh-my-zsh is setup
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    # setup oh-my-zsh
    echo "Setting up oh-my-zsh..."
    git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
fi

# check if patch is present
if ! [ -x "$(command -v patch)" ]; then
    # install patch
    echo "Installing patch..."
    $PREFIX_SUDO pacman -S patch --noconfirm
fi

# check if fakeroot is present
if ! [ -x "$(command -v fakeroot)" ]; then
    # install fakeroot
    echo "Installing fakeroot..."
    $PREFIX_SUDO pacman -S fakeroot --noconfirm
fi

# check if yay is present
if ! [ -x "$(command -v yay)" ]; then
    # install yay
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git $HOME/yay
    cd $HOME/yay
    makepkg -si --noconfirm
    cd $HOME
    rm -rf $HOME/yay
fi

# check if ansible is installed
if ! [ -x "$(command -v ansible)" ]; then
    # install ansible
    echo "Installing Ansible..."
    $PREFIX_SUDO pacman -S ansible --noconfirm
fi

# check if public key is already in place
if ! [[ -f "$SSH_DIR/id_rsa" ]]; then
    # create ssh dir
    echo "Creating SSH dir..."
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"

    # check if openssh is installed
    if ! [ -x "$(command -v ssh-keygen)" ]; then
        # install openssh
        echo "Installing OpenSSH..."
        $PREFIX_SUDO pacman -S openssh --noconfirm
    fi

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

# check if dotfiles are already present
if ! [[ -d "$DOTFILES_DIR" ]]; then
    # clone dotfiles
    echo "Cloning dotfiles..."
    git clone https://github.com/chhetrisushil/dotfiles.git "$DOTFILES_DIR"

    # add $HOME/.local/bin to PATH
    echo "Adding $HOME/.local/bin to PATH..."
    export PATH=$HOME/.local/bin:$PATH
else
    # update dotfiles
    echo "Updating dotfiles..."
    git -C "$DOTFILES_DIR" pull
fi

# check if requirements.yml is present
if [[ -f "$DOTFILES_DIR/requirements.yml" ]]; then
    # change into dotfiles dir
    echo "Changing into dotfiles dir..."
    cd "$DOTFILES_DIR"

    # check if requirements
    echo "Checking requirements..."
    ansible-galaxy install -r "$DOTFILES_DIR/requirements.yml"
fi

# check if main.yml is present
if [[ -f "$DOTFILES_DIR/main.yml" ]]; then
    # change into dotfiles dir
    echo "Changing into dotfiles dir..."
    cd "$DOTFILES_DIR"

    # run ansible
    echo "Running ansible..."
    ansible-playbook --diff "$DOTFILES_DIR/main.yml" --ask-become-pass
fi
