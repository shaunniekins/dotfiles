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

## About install.sh
The repo contains all configuration I use with tmux, zsh, and vim.

The install script does the following  :
* Install required package depending on OS (tmux/zsh/oh-my-zsh/vim)
* Install vim plugins
* Symlink tmux.conf, .zshrc, .vimrc, and a theme of oh-my-zsh (spaceship)

## TO do  
* test backup files
* add zc shortcut (vim package to compress code part)
* add shortcuts




