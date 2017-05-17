#!/bin/sh
# Script install packages requirements, oh-my-zsh, config files (with symlinks), font and Colors


echo "=============================="
echo -e "\n\nInstalling packages ..."
echo "=============================="

package_to_install="vim
    tmux
    tree
    wget
    zsh
    curl
"
 if cat /etc/*release | grep ^NAME | grep CentOS; then
    echo "==============================================="
    echo "Installing packages $package_to_install on CentOS"
    echo "==============================================="
    yum install -y $package_to_install
 elif cat /etc/*release | grep ^NAME | grep Red; then
    echo "==============================================="
    echo "Installing packages $package_to_install on RedHat"
    echo "==============================================="
    yum install -y $package_to_install
 elif cat /etc/*release | grep ^NAME | grep Fedora; then
    echo "================================================"
    echo "Installing packages $package_to_install on Fedorea"
    echo "================================================"
    yum install -y $package_to_install
 elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
    echo "==============================================="
    echo "Installing packages $package_to_install on Ubuntu"
    echo "==============================================="
    apt-get update
    apt-get install -y $package_to_install
 elif cat /etc/*release | grep ^NAME | grep Debian ; then
    echo "==============================================="
    echo "Installing packages $package_to_install on Debian"
    echo "==============================================="
    apt-get update
    apt-get install -y $package_to_install
 elif cat /etc/*release | grep ^NAME | grep Mint ; then
    echo "============================================="
    echo "Installing packages $package_to_install on Mint"
    echo "============================================="
    apt-get update
    apt-get install -y $package_to_install
 elif cat /etc/*release | grep ^NAME | grep Knoppix ; then
    echo "================================================="
    echo "Installing packages $package_to_install on Kanoppix"
    echo "================================================="
    apt-get update
    apt-get install -y $package_to_install
 elif uname -s | grep Darwin ; then
    echo "================================================="
    echo "Installing packages $package_to_install on Mac OS"
    echo "================================================="
    brew update
    brew install $package_to_install
 else
    echo "OS NOT DETECTED, couldn't install package $package_to_install"
    exit 1;
 fi

echo "================================================="
echo "Installing packages Oh-my-zsh"
echo "================================================="
# Installing oh-my-zsh within a script. Source: https://github.com/robbyrussell/oh-my-zsh/issues/5873
sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch


echo "================================================="
echo "Symlink zsh theme, tmux.conf, vimrc, zshrc"
echo "================================================="

DOTFILES=$HOME/.ide_config

echo "Symlinking dotfiles"
ln -s $DOTFILES/zsh/oh-my-zsh/themes/spaceship.zsh-theme.symlink $HOME/.oh-my-zsh/themes/spaceship.zsh-theme
ln -s $DOTFILES/vim/vimrc.symlink $HOME/.vimrc
ln -s -f $DOTFILES/zsh/zshrc.symlink $HOME/.zshrc

echo "================================================="
echo "Installing packages vundle and activate plugins"
echo "================================================="

# Install Vundle if it is not installed
echo
if [ ! -d $HOME/.vim/bundle/Vundle.vim ]
then
    echo "Installing Vundle"
    sudo mv $HOME/.vim $HOME/.vim.old
    mkdir -p $HOME/.vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
else
    echo "Vundle already installed"
fi

# This hack removes the Vim UI output
# Source: https://github.com/VundleVim/Vundle.vim/issues/511
echo "Installing Vundle plugins"
echo | echo | vim +PluginInstall +qall &>/dev/null

echo "================================================="
echo "Font & color for vim"
echo "================================================="

# fonts
wget https://github.com/powerline/fonts/blob/master/Inconsolata/Inconsolata%20for%20Powerline.otf
wget https://github.com/powerline/fonts/blob/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf
mkdir -p ~/.fonts && mv DejaVu\ Sans\ Mono\ for\ Powerline.ttf ~/.fonts/ && mv Inconsolata\ for\ Powerline.otf ~/.fonts/
## for centos/ubuntu/ mac ?!
fc-cache -vf ~/.fonts/

# Colors
wget https://raw.githubusercontent.com/vim-scripts/wombat256.vim/master/colors/wombat256mod.vim
mkdir -p $HOME/.vim/colors && mv wombat256mod.vim $HOME/.vim/colors/
ln -s $DOTFILES/tmux/tmux.conf.symlink $HOME/.tmux.conf

