#!/bin/sh

## Script to install tmux,zsh,oh-my-zsh
echo -e "\n\nInstalling packages ..."
echo "=============================="

formulas="git
    tmux
    tree
    wget
    zsh
"

 if cat /etc/*release | grep ^NAME | grep CentOS; then
    echo "==============================================="
    echo "Installing packages $formulas on CentOS"
    echo "==============================================="
    yum install -y $formulas
 elif cat /etc/*release | grep ^NAME | grep Red; then
    echo "==============================================="
    echo "Installing packages $formulas on RedHat"
    echo "==============================================="
    yum install -y $formulas
 elif cat /etc/*release | grep ^NAME | grep Fedora; then
    echo "================================================"
    echo "Installing packages $formulas on Fedorea"
    echo "================================================"
    yum install -y $formulas
 elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
    echo "==============================================="
    echo "Installing packages $formulas on Ubuntu"
    echo "==============================================="
    apt-get update
    apt-get install -y $formulas
 elif cat /etc/*release | grep ^NAME | grep Debian ; then
    echo "==============================================="
    echo "Installing packages $formulas on Debian"
    echo "==============================================="
    apt-get update
    apt-get install -y $formulas
 elif cat /etc/*release | grep ^NAME | grep Mint ; then
    echo "============================================="
    echo "Installing packages $formulas on Mint"
    echo "============================================="
    apt-get update
    apt-get install -y $formulas
 elif cat /etc/*release | grep ^NAME | grep Knoppix ; then
    echo "================================================="
    echo "Installing packages $formulas on Kanoppix"
    echo "================================================="
    apt-get update
    apt-get install -y $formulas
 elif uname -s | grep Darwin ; then
    echo "================================================="
    echo "Installing packages $formulas on Mac OS"
    echo "================================================="
    brew update
    brew install $formulas
 else
    echo "OS NOT DETECTED, couldn't install package $formulas"
    exit 1;
 fi

## Script to install tmux,zsh,oh-my-zsh
echo -e "\n\nInstalling Oh-My-Zsh ..."
echo "=============================="

# Install Oh-My-Zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
