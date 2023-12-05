#!/bin/bash

# Update system
sudo pacman -Syu

# Install necessary dependencies
sudo pacman -S base-devel git

# Install yay AUR helper
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Define a function to install packages
install_package() {
    echo "Installing $1..."
    yay -S --noconfirm $1
}

# Define a function to clone dotfiles repository
clone_dotfiles() {
    echo "Cloning dotfiles repository..."
    git clone https://github.com/shaunniekins/dotfiles.git
    cd dotfiles
}

# Define a function to replace configurations
replace_config() {
    local source_dir=$1
    local target_dir=~/.config/$(basename $source_dir)

    echo "Replacing $source_dir configuration..."

    # Check if the target directory exists, and create it if not
    if [ ! -d $target_dir ]; then
        echo "Creating target directory: $target_dir"
        mkdir -p $target_dir
    fi

    # Copy the configuration files
    echo "Copying files to $target_dir..."
    cp -r $source_dir/* $target_dir/
}

# Install packages
install_package qtile
install_package ly
install_package xfce4-terminal
install_package google-chrome
install_package pcmanfm
install_package visual-studio-code-bin
install_package vim
install_package nomacs
install_package nitrogen
install_package lanxchange
install_package neofetch
install_package obs-studio
install_package rofi
install_package flameshot
install_package lxappearance
install_package onlyoffice-desktopeditors
install_package vtop
install_package dunst
install_package pulseaudio
install_package networkmanager
install_package rofi-wifi-menu
install_package arandr
install_package xorg-xrandr
install_package bluez
install_package blueman
install_package orchis-theme
install_package ttf-ubuntu-font-family

# Set GTK theme (replace 'Orchis-dark' with the desired theme)
lxappearance

# Set icon theme (select 'Inverse blue dark' in lxappearance)
lxappearance

# Clone dotfiles repository
clone_dotfiles

# Replace configurations
replace_config qtile
replace_config dunst
replace_config rofi

# Enable and start ly.service
sudo systemctl enable ly.service
sudo systemctl start ly.service

echo "Configuration complete. Restarting the system in 5 seconds..."
sleep 5
sudo reboot
