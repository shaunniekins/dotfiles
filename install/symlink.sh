#!/usr/bin/env bash

DOTFILES=$HOME/.ide_config

echo -e "\nCreating symlinks in  ~/"
echo "=============================="
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
echo "for files : "
echo $linkables

for file in $linkables ; do
    target="$HOME/.$( basename $file '.symlink' )"
    if [ -e $target ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $file"
        ln -s $file $target
    fi
done


echo -e "\n\nCreating symlink for zsh theme to ~/.oh-my-zsh/themes/"
echo "=============================="
target_theme=$HOME/.oh-my-zsh/themes/spaceship.zsh-theme

theme_path=$DOTFILES/zsh/oh-my-zsh/themes/spaceship.zsh-theme.symlink

echo "Creating symlink for $theme"
ln -s $theme $target_theme


