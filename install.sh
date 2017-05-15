#!/usr/bin/env bash

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing packages"

source install/package_install.sh


echo "installing Oh-my-zsh"

source install/ohmyzsh.sh

echo "Initializing dotfiles."

source install/symlink.sh

if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s $(which zsh)
fi

echo "Done. Reload your terminal."
