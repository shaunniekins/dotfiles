# ide_config : tmux, zsh, vim configured in a proper way

## Getting Started

### Prerequisite
The install script backup the existing configuration file, but read below before running it ! 
Requirements : 
* git
* brew (on MacOs)
** tested on MacOs/Ubuntu/Debian/Centos

### Install
```
git clone https://github.com/mehd-io/ide_config ~/.ide_config
cd ~/.ide_config
./install.sh
```

### Terminal configuration : color & fonts
* Fonts used "DejaVu Sans Mono for Powerline.ttf" and  "Inconsolata for Powerline.otf" are in terminal/fonts folder
* colors used "FrontEndDelight" are in terminal/colors folder (iterm2) for more colors or other terminal support, check : https://github.com/mbadolato/iTerm2-Color-Schemes

## About install.sh
The repo contains all configuration I use with tmux, zsh, and vim.

The install script does the following  :
* Install required package depending on OS (tmux/zsh/oh-my-zsh/vim)
* Install vim plugins
* Symlink tmux.conf, .zshrc, .vimrc, and a theme of oh-my-zsh (spaceship)

## Oh-my-zsh theme : spaceship
Spaceship is a highly flexible theme of oh my zsh, for more info : https://github.com/denysdovhan/spaceship-zsh-theme

## Tmux
command key remapped from ctrl+b to ctrl+space

## To do
* add screenshots


