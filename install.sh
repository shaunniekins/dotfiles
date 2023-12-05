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
    echo "Replacing $1 configuration..."
    cp $1 ~/.config/$1
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
