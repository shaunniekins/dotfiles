# 🚀 Dotfiles

A clean, organized dotfiles setup with automatic tmux session management, Pure prompt, and comprehensive tool integration.

## ✨ Features

- **🖥️ Automatic tmux sessions** — Every terminal automatically starts in tmux
- **🎨 Pure prompt** — Minimal, fast zsh prompt
- **⚡ Oh-My-Zsh** — Powerful zsh framework with useful plugins
- **🪟 Window Management** — Aerospace and skhd for macOS
- **💾 Session Persistence** — tmux-resurrect and tmux-continuum
- **🎯 Organized Configuration** — Clean, well-commented config files

## 📋 Prerequisites

- macOS (tested) or Linux
- Git
- Homebrew (for macOS)
- Curl
- zsh 5.0.5+ (otherwise some themes may not display colors correctly)

## 🛠️ Installation

```bash
# Clone the repository
git clone https://github.com/shaunniekins/dotfiles.git ~/.dotfiles

# Run installation script
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

The installation script will:

1. Backup existing configuration files
2. Install required packages (neovim, tmux, zsh, etc.)
3. Install Oh-My-Zsh and plugins (zsh-syntax-highlighting)
4. Setup Pure prompt
5. Create symlinks for all config files
6. Configure tmux to auto-start
7. Start macOS services (skhd, Aerospace)

### Install TPM (if not already installed)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then press `prefix + I` inside tmux to install plugins.

## 📁 Structure

```
.dotfiles/
├── install.sh                          # Main installation script
├── zsh/
│   ├── zshrc.symlink                  # Main zsh configuration
│   ├── zprofile.symlink               # Zsh profile
│   ├── setup_plugins.sh               # Plugin installation script
│   └── setup_pure.sh                  # Pure prompt setup
├── tmux/
│   ├── tmux.conf.symlink              # Base tmux config (do not edit)
│   └── tmux.conf.local.symlink        # Your tmux customizations
├── skhd/
│   └── skhdrc.symlink                 # Keyboard shortcuts (macOS)
└── aerospace/
    └── aerospace.toml                 # Window manager config (macOS)
```

## 🔄 Updating

### After pulling changes from git

```bash
cd ~/.dotfiles
git pull
```

You do **not** need to re-run `install.sh` every time. Instead, reload only the component you changed:

### Reload zsh config

```bash
source ~/.zshrc
```

### Reload tmux config

From **inside tmux**, press `prefix + r` or run:

```bash
tmux source ~/.tmux.conf
```

> **Note:** If you changed `default-terminal` or other server-level settings, you need a full restart:
>
> ```bash
> tmux kill-server
> ```
>
> Then reopen your terminal (tmux will auto-start).

### Reload skhd

```bash
skhd --restart-service
```

### When to re-run install.sh

Only re-run `install.sh` if you need to:

- Install new system packages
- Reinstall Oh-My-Zsh or plugins
- Recreate symlinks (e.g. after moving the dotfiles directory)
- Set up on a new machine

## ⌨️ Key Bindings

### Tmux (prefix = Ctrl+b)

**Window Management:**

| Shortcut         | Action                  |
| ---------------- | ----------------------- |
| `prefix + n`     | Next window             |
| `prefix + p`     | Previous window         |
| `prefix + [0-9]` | Switch to window number |
| `prefix + ,`     | Rename window           |
| `prefix + w`     | List windows            |

**Pane Management:**

| Shortcut         | Action                     |
| ---------------- | -------------------------- |
| `prefix + h`     | Split horizontally         |
| `prefix + v`     | Split vertically           |
| `prefix + k/j/l` | Navigate panes (vim-style) |
| `prefix + ^`     | Last window                |

**Copy Mode:**

| Shortcut     | Action                           |
| ------------ | -------------------------------- |
| `prefix + [` | Enter copy mode                  |
| `v`          | Begin selection (in copy mode)   |
| `y`          | Yank to clipboard (in copy mode) |
| `prefix + ]` | Paste from tmux buffer           |
| `Cmd + V`    | Paste from system clipboard      |

**Plugin Management:**

| Shortcut           | Action                    |
| ------------------ | ------------------------- |
| `prefix + I`       | Install plugins           |
| `prefix + U`       | Update plugins            |
| `prefix + alt + u` | Uninstall removed plugins |

### Zsh

| Shortcut   | Action                 |
| ---------- | ---------------------- |
| `Ctrl + R` | Reverse history search |
| `Tab`      | Auto-completion menu   |

## 🔧 Customization

### Tmux Configuration

Edit `tmux/tmux.conf.local.symlink` for your tmux customizations. **Do not edit** `tmux/tmux.conf.symlink` — that is the base config from [gpakosz/.tmux](https://github.com/gpakosz/.tmux).

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

### Modifying Path

Edit `zsh/zshrc.symlink` in the "PATH CONFIGURATION" or "ADDITIONAL PATH CONFIGURATIONS" sections.

### Terminal Configuration

Fonts: "DejaVu Sans Mono for Powerline.ttf" and "Inconsolata for Powerline.otf" are in `terminal/fonts` folder.

Colors: "FrontEndDelight" are in `terminal/colors` folder (iTerm2). For more colors or other terminal support, check: [iTerm2-Color-Schemes](https://github.com/mbadolato/iTerm2-Color-Schemes)

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

### Garbage text in tmux panes

If you see text like `10;rgb:e6e6/eded/f3f3...` in panes, ensure `tmux.conf.local.symlink` has:

```bash
set -g default-terminal "tmux-256color"
set -g allow-passthrough off
set -g set-clipboard on
```

Then fully restart tmux:

```bash
tmux kill-server
```

### Copy/paste not working in tmux

1. Make sure `tmux-yank` plugin is installed: `prefix + I`
2. Verify clipboard settings in `tmux.conf.local.symlink`:

   ```bash
   set -g set-clipboard on
   set -g @yank_selection 'clipboard'
   ```

3. Use `prefix + [` to enter copy mode, `v` to select, `y` to yank

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

- **neovim** — Modern vim
- **tmux** — Terminal multiplexer
- **zsh** — Advanced shell
- **tree** — Directory viewer
- **wget/curl** — File downloaders
- **skhd** — Hotkey daemon (macOS)
- **aerospace** — Window manager (macOS)

## 🙏 Credits

- [Oh-My-Zsh](https://ohmyz.sh/)
- [Pure Prompt](https://github.com/sindresorhus/pure)
- [tmux](https://github.com/tmux/tmux)
- [gpakosz/.tmux](https://github.com/gpakosz/.tmux)
- [Aerospace](https://github.com/nikitabobko/AeroSpace)
