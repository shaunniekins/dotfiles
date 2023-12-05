# My Linux Setup on Arch

## Introduction

This README outlines the software and configuration I use on my Arch Linux system. Feel free to use this as a reference or inspiration for your own Linux setup.

## Getting Started

### 1. Install Arch Linux

Follow the official Arch Linux installation guide to set up your system: [Arch Linux Installation Guide](https://archlinux.org/)

### 2. Clone Dotfiles Repository

Clone my dotfiles repository to access my configuration files:

```bash
git clone https://github.com/shaunniekins/dotfiles.git
cd dotfiles
```

### 3. Install Software

Use the provided install.sh script to install the software and dependencies. Make the script executable and run it:

```bash
chmod +x install.sh
./install.sh
```

### 4. Replace Configurations

After installing the software, replace the default configurations with my dotfiles:

```bash
# Replace Qtile configuration
cp qtile ~/.config/qtile

# Replace Dunst configuration
cp dunst ~/.config/dunst

# Replace Rofi configuration
cp rofi ~/.config/rofi
```

Adjust the paths based on the structure of the dotfiles repository.

### 5. Additional Configurations
- Set GTK theme using Lxappearance.
- Set icon theme to 'Inverse blue dark' in Lxappearance.


## Software List

|Program / Software		| Name																	|
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| Distribution		| [Arch Linux](https://archlinux.org/)													|
| WM			| [Qtile](https://wiki.archlinux.org/title/Qtile)												|
| Bar		| [Qtile](https://wiki.archlinux.org/title/Qtile)											|
| Display Manager		| [Ly](https://gist.github.com/miguelmota/f6a11cebd9bdb6bb2ad813e99c1262b9)								|
| Terminal emulator	| [Xfce4 Terminal](https://archlinux.org/packages/extra/x86_64/xfce4-terminal/)										|
| Browser	| [Brave](https://brave.com/)										|
| File Manager	| [PCManFM](https://wiki.archlinux.org/title/PCManFM)										|
| IDE'S			| [VSCode](https://wiki.archlinux.org/title/Visual_Studio_Code), [Vim](https://wiki.archlinux.org/title/Vim)			|
| Image viewer		| [Nomacs](https://nomacs.org/download/)	`											|
| Background setter	| [Nitrogen](https://wiki.archlinux.org/title/Nitrogen)											|
| File Transfer	| [LanXchange](https://lanxchange.com/)											|
| Info app	| [Neofetch](https://github.com/dylanaraps/neofetch)											|
| Screencasting	| [OBS Studio](https://obsproject.com/download)											|
| Launchers		| [Rofi (dmenu-themed)](https://wiki.archlinux.org/title/Rofi)					|
| Screenshots		| [Flameshot](https://flameshot.org/)       |
| Theme Switcher		| [Lxappearance](https://archlinux.org/packages/community/x86_64/lxappearance/)       |
| Office	| [Onlyoffice](https://www.onlyoffice.com/en/desktop.aspx)											|
| Top		| [Vtop](https://aur.archlinux.org/packages/vtop)		|
| Notifications		| [Dunst](https://wiki.archlinux.org/title/Dunst)											|
| Sound			| [Pulseaudio](https://wiki.archlinux.org/title/PulseAudio)		|
| Network		| [Network manager](https://wiki.archlinux.org/title/NetworkManager), [Rofi-wifi-menu](https://github.com/ericmurphyxyz/rofi-wifi-menu)									|
| Monitor resolution	| [ARandR](https://archlinux.org/packages/community/any/arandr/), [Xrandr](https://wiki.archlinux.org/title/Xrandr)											|									|
| Bluetooth   | [Bluez](http://www.bluez.org/), [Blueman](https://github.com/blueman-project/blueman).    |
| GTK Themes		| [Orchis theme](https://aur.archlinux.org/packages/orchis-theme)										|
| Icon Theme		| Inverse blue dark			|
| Fonts | Ubuntu	|
