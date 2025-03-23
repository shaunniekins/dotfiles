# dotfiles : tmux, zsh, vim configured in a proper way

## Getting Started

### Prerequisite

The install script backs up existing configuration files, but please read below before running it!
Requirements:

* git
* brew (on MacOS)
* zsh 5.0.5 minimum (otherwise some themes may not display colors correctly)
* Tested on MacOS/Ubuntu/Debian/Centos

### Install

```bash
git clone https://github.com/shaunniekins/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

### Terminal configuration: color & fonts

* Fonts used "DejaVu Sans Mono for Powerline.ttf" and "Inconsolata for Powerline.otf" are in terminal/fonts folder
* Colors used "FrontEndDelight" are in terminal/colors folder (iterm2) for more colors or other terminal support, check: <https://github.com/mbadolato/iTerm2-Color-Schemes>

## About install.sh

The repo contains all configuration I use with tmux, zsh, yabai, and skhd.

The install script does the following:

* Install required packages depending on OS (tmux/zsh/oh-my-zsh/neovim)
* Install zsh plugins (zsh-autosuggestions, zsh-syntax-highlighting)
* Set up Pure prompt
* Symlink tmux.conf, .zshrc, .yabairc, .skhdrc and other configuration files

## zsh with Pure prompt

Pure is a minimal and fast ZSH prompt. For more info: <https://github.com/sindresorhus/pure>

## Tmux

Command key remapped from ctrl+b to ctrl+a
Using theme from: <https://github.com/gpakosz/.tmux>

### Copying text in tmux (macOS)

* Regular method: Hold Shift while selecting text with mouse

* If mouse selection/tmux-yank stops working on macOS:
  * Use Cmd+R to enter selection mode
  * Select text you want to copy
  * Press Enter to copy the selection to clipboard

## Yabai and skhd

Yabai is a tiling window manager with skhd for keyboard shortcuts.

* Yabai: <https://github.com/koekeishiya/yabai>
* skhd: <https://github.com/koekeishiya/skhd>

## To do

* Add screenshots
