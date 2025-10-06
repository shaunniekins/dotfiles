# 🚀 Dotfiles Configuration# dotfiles : zsh, vim configured in a proper way

A clean, organized dotfiles setup with automatic tmux session management, Pure prompt, and comprehensive tool integration.## Getting Started

## ✨ Features### Prerequisite

- **🖥️ Automatic tmux sessions** - Every terminal automatically starts in tmuxThe install script backs up existing configuration files, but please read below before running it!

- **🎨 Pure prompt** - Minimal, fast zsh promptRequirements:

- **⚡ Oh-My-Zsh** - Powerful zsh framework with useful plugins

- **🪟 Window Management** - Aerospace and skhd for macOS* git

- **💾 Session Persistence** - tmux-resurrect and tmux-continuum* brew (on MacOS)

- **🎯 Organized Configuration** - Clean, well-commented config files* zsh 5.0.5 minimum (otherwise some themes may not display colors correctly)

- Tested on MacOS/Ubuntu/Debian/Centos

## 📋 Prerequisites

### Install

- macOS (tested) or Linux

- Git```bash

- Homebrew (for macOS)git clone <https://github.com/shaunniekins/dotfiles> ~/.dotfiles

- Curlcd ~/.dotfiles

./install.sh

## 🛠️ Installation```

```bash### Terminal configuration: color & fonts

# Clone the repository

git clone https://github.com/shaunniekins/dotfiles.git ~/.dotfiles* Fonts used "DejaVu Sans Mono for Powerline.ttf" and "Inconsolata for Powerline.otf" are in terminal/fonts folder

* Colors used "FrontEndDelight" are in terminal/colors folder (iterm2) for more colors or other terminal support, check: <https://github.com/mbadolato/iTerm2-Color-Schemes>

# Run installation script

cd ~/.dotfiles## About install.sh

chmod +x install.sh

./install.shThe repo contains all configuration I use with  zsh, and skhd.

```

The install script does the following:

The installation script will:

1. Backup existing configuration files* Install required packages depending on OS (zsh/oh-my-zsh/neovim)

2. Install required packages* Install zsh plugins (zsh-syntax-highlighting)

3. Install Oh-My-Zsh and plugins* Set up Pure prompt

4. Setup Pure prompt* Symlink .zshrc, .skhdrc and other configuration files

5. Create symlinks for all config files

6. Configure tmux to auto-start## zsh with Pure prompt

## 📁 StructurePure is a minimal and fast ZSH prompt. For more info: <https://github.com/sindresorhus/pure>

```## skhd

.dotfiles/

├── install.sh                 # Main installation scriptSkhd for keyboard shortcuts.

├── zsh/

│   ├── zshrc.symlink         # Main zsh configuration* skhd: <https://github.com/koekeishiya/skhd>

│   ├── setup_plugins.sh      # Plugin installation script

│   └── setup_pure.sh         # Pure prompt setup## To do

├── tmux/

│   └── tmux.conf.symlink     # Tmux configuration* Add screenshots

├── skhd/

│   └── skhdrc.symlink        # Keyboard shortcuts (macOS)Install TPM (if not already installed):

└── aerospace/

    └── aerospace.toml        # Window manager config (macOS)```bash

```git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

```

## 🎯 Key Features Explained

### Automatic tmux Sessions

Every new terminal automatically starts tmux and attaches to the `main` session. This ensures:

- Persistent sessions across terminal closes
- Consistent working environment
- Session recovery after system restarts

### Configuration Organization

All configuration files are organized by category and use clear section headers:

- Path configurations
- Plugin settings
- Key bindings
- External integrations

## ⌨️ Key Bindings

### Tmux (prefix = Ctrl+b)

**Window Management:**

- `prefix + n` - Next window
- `prefix + p` - Previous window
- `prefix + [0-9]` - Switch to window number
- `prefix + ,` - Rename window
- `prefix + w` - List windows

**Pane Management:**

- `prefix + h` - Split horizontally
- `prefix + v` - Split vertically
- `prefix + h/j/k/l` - Navigate panes (vim-style)

**Plugin Management:**

- `prefix + I` - Install plugins
- `prefix + U` - Update plugins
- `prefix + alt + u` - Uninstall removed plugins

### Zsh

- `Ctrl + R` - Reverse history search
- `Tab` - Auto-completion menu

## 🔧 Customization

### Adding New Plugins

Edit `zsh/zshrc.symlink`:

```bash
plugins=(
  git
  z
  zsh-syntax-highlighting
  your-new-plugin  # Add here
)
```

### Changing tmux Theme

Edit `tmux/tmux.conf.symlink` in the "PLUGIN CONFIGURATION" section.

### Modifying Path

Edit `zsh/zshrc.symlink` in the "PATH CONFIGURATION" or "ADDITIONAL PATH CONFIGURATIONS" sections.

## 🔄 Updating

```bash
cd ~/.dotfiles
git pull
./install.sh  # Re-run if needed
```

To reload configurations without re-running the installer:

```bash
# Reload zsh
source ~/.zshrc

# Reload tmux (inside tmux)
tmux source ~/.tmux.conf
```

## 🐛 Troubleshooting

### tmux doesn't auto-start

Check that tmux is installed:

```bash
command -v tmux
```

Verify the symlink exists:

```bash
ls -la ~/.tmux.conf
```

### Plugins not working

Reinstall plugins:

```bash
cd ~/.dotfiles
./zsh/setup_plugins.sh
```

### Pure prompt not showing

Reinstall Pure:

```bash
cd ~/.dotfiles
./zsh/setup_pure.sh
```

Then reload zsh:

```bash
source ~/.zshrc
```

## 📦 Included Packages

- **neovim** - Modern vim
- **tmux** - Terminal multiplexer
- **zsh** - Advanced shell
- **tree** - Directory viewer
- **wget/curl** - File downloaders
- **skhd** - Hotkey daemon (macOS)
- **aerospace** - Window manager (macOS)

## 🤝 Contributing

Feel free to fork and customize for your needs!

## 📝 License

MIT

## 🙏 Credits

- [Oh-My-Zsh](https://ohmyz.sh/)
- [Pure Prompt](https://github.com/sindresorhus/pure)
- [tmux](https://github.com/tmux/tmux)
- [Aerospace](https://github.com/nikitabobko/AeroSpace)
