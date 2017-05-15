#!/usr/bin/env bash

DOTFILES=$HOME/.ide_config

echo "Symlinking dotfiles"
ln -s $DOTFILES/zsh/oh-my-zsh/themes/spaceship.zsh-theme.symlink ~/.oh-my-zsh/themes/spaceship.zsh-theme
ln -s $DOTFILES/tmux.conf.symlink ~/.tmux.conf
ln -s $DOTFILES/vimrc.symlink ~/.vimrc
ln -s $DOTFILES/zshrc.symlink ~/.zshrc
