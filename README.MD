# 🚀 Dotfiles

A clean, organized dotfiles setup with automatic tmux session management, Pure prompt, and comprehensive tool integration.

## ✨ Features

- **🖥️ Automatic tmux sessions** — Every interactive shell attaches to a tmux session named `main`
- **💾 Session persistence** — tmux-resurrect + tmux-continuum restore your windows, panes, and scrollback across reboots
- **🎨 Pure prompt** — Minimal, fast zsh prompt
- **⚡ Oh-My-Zsh** — zsh framework with `git`, `z`, and syntax highlighting
- **🔵 tmux-dotbar** — Minimal dotted tmux status bar
- **🪟 Window management** — Aerospace and skhd for macOS
- **📋 System clipboard** — tmux-yank + OSC 52, so `y` in copy mode reaches `Cmd+V`

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

1. Prompt whether to overwrite existing configs, then back them up to `~/dotfiles-backup`
2. Install required packages (neovim, tmux, zsh, tree, wget, curl, skhd, cmatrix, neofetch)
3. Install Aerospace via Homebrew cask (macOS)
4. Install Oh-My-Zsh, `zsh-syntax-highlighting`, and `reattach-to-user-namespace` (macOS)
5. Set up the Pure prompt into `~/.zfunctions`
6. Symlink `~/.zshrc`, `~/.tmux.conf`, and `~/.aerospace.toml` (macOS)
7. Set zsh as the default shell (`chsh`)
8. Start the skhd service and launch Aerospace (macOS)

> **Note:** `install.sh` requires **bash** (it uses `read -p`, `[[ ... ]]`, and `echo -e`) and
> declares `#!/bin/bash`. Invoke it as `./install.sh` or `bash install.sh` — running it as
> `sh install.sh` forces a POSIX shell and the confirmation prompt will silently default to "no".

> **Note:** Oh-My-Zsh, `zsh-syntax-highlighting`, and Pure are **removed and re-cloned** on every
> run — any manual changes inside them are lost.

### Install TPM (required for tmux plugins)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then press `prefix + I` inside tmux to install plugins.

> **Note:** Session persistence will not work until the plugins are installed.

## 📁 Structure

```
.dotfiles/
├── install.sh                          # Main installation script
├── zsh/
│   ├── zshrc.symlink                  # Main zsh configuration → ~/.zshrc
│   ├── setup_plugins.sh               # Oh-My-Zsh plugin installation
│   └── setup_pure.sh                  # Pure prompt setup
├── tmux/
│   ├── tmux.conf.symlink              # The tmux config → ~/.tmux.conf (edit this)
│   └── tmux.conf.original.symlink     # Archived gpakosz/.tmux base (unused reference)
├── skhd/
│   └── skhdrc.symlink                 # Keyboard shortcuts (macOS, not symlinked by default)
└── aerospace/
    └── aerospace.toml                 # Window manager config (macOS) → ~/.aerospace.toml
```

## 💾 Session Persistence

Sessions, windows, panes, working directories, and pane scrollback survive a reboot.

**How it works:**

- **tmux-resurrect** does the saving and restoring, writing snapshots to `~/.local/share/tmux/resurrect/`.
- **tmux-continuum** triggers a save every 5 minutes and restores automatically when the tmux server starts.

| Setting                              | Value | Meaning                                    |
| ------------------------------------ | ----- | ------------------------------------------ |
| `@continuum-restore`                 | `on`  | Auto-restore on tmux server start          |
| `@continuum-save-interval`           | `5`   | Save every 5 minutes                       |
| `@resurrect-capture-pane-contents`   | `on`  | Also save/restore pane scrollback          |

**Manual save/restore** (tmux-resurrect defaults):

| Shortcut          | Action                     |
| ----------------- | -------------------------- |
| `prefix + Ctrl-s` | Save the environment now   |
| `prefix + Ctrl-r` | Restore the last snapshot  |

> **⚠️ Plugin order matters.** In `tmux.conf.symlink`, `tmux-dotbar` **must** be listed before
> `tmux-continuum`. TPM loads plugins in listed order. Continuum implements its periodic autosave by
> appending a `#(continuum_save.sh)` interpolation to `status-right`, which tmux re-evaluates every
> `status-interval`. Because tmux-dotbar unconditionally overwrites `status-right`, listing it last
> silently wipes that hook — autosaving stops permanently and there is nothing left to restore after a
> reboot. Keep `tmux-continuum` last in the plugin list.

> **Note:** Continuum does not save on shutdown, so a reboot loses at most the last 5 minutes of layout
> changes. Press `prefix + Ctrl-s` before a planned restart if you want an exact snapshot.

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
> Then reopen your terminal (tmux will auto-start). Save first with `prefix + Ctrl-s` — `kill-server`
> discards anything not yet snapshotted.

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

> **Note:** The prefix is left at the tmux default `Ctrl+b`. `Ctrl+a` is bound to `send-prefix`,
> which forwards a literal prefix to a nested tmux or a program that wants it.

**Window Management:**

| Shortcut         | Action                  |
| ---------------- | ----------------------- |
| `prefix + n`     | Next window             |
| `prefix + p`     | Previous window         |
| `prefix + ^`     | Last window             |
| `prefix + [0-9]` | Switch to window number |
| `prefix + ,`     | Rename window           |
| `prefix + $`     | Rename session          |
| `prefix + w`     | List windows            |
| `prefix + r`     | Reload tmux config      |

**Pane Management:**

| Shortcut       | Action                            |
| -------------- | --------------------------------- |
| `prefix + h`   | Split left/right (`split -h`)     |
| `prefix + v`   | Split top/bottom (`split -v`)     |
| `prefix + k`   | Select pane above                 |
| `prefix + j`   | Select pane below                 |
| `prefix + l`   | Select pane to the right          |

> **Note:** There is no "select pane to the left" binding — `prefix + h` is bound to splitting.
> Windows are numbered from 1 and renumbered automatically when one closes. Mouse mode is on, so
> panes can also be selected and resized by clicking and dragging.

**Copy Mode** (vi keys):

| Shortcut         | Action                                     |
| ---------------- | ------------------------------------------ |
| `prefix + [`     | Enter copy mode                            |
| `v`              | Begin selection (in copy mode)             |
| `y`              | Copy to **system clipboard** and exit      |
| `Escape`         | Leave copy mode                            |
| Mouse drag       | Copies to system clipboard on release      |
| Double-click     | Copy word                                  |
| Triple-click     | Copy line                                  |
| `prefix + C-v`   | Paste the **system clipboard**             |
| `prefix + ]`     | Paste tmux's own buffer                    |
| `Cmd + V`        | Paste (terminal types the clipboard)       |

> **There is no `Cmd + C` binding, and there cannot be one.** macOS never delivers `Cmd` to the TTY,
> so tmux cannot see it, and `Ctrl + C` must stay `SIGINT`. Instead every selection path above pipes
> straight into the system clipboard — the text is in your clipboard the moment you release the drag
> or press `y`, so no copy keystroke is needed.
>
> If you specifically want a native terminal selection that `Cmd + C` copies (to select across panes,
> or to avoid tmux's per-pane line wrapping), hold **Option** while dragging. In VS Code's integrated
> terminal that requires `"terminal.integrated.macOptionClickForcesSelection": true`; iTerm2 and
> Terminal.app do it by default.
>
> **Why `prefix + C-v` exists:** `prefix + ]` pastes tmux's internal buffer, which drifts out of sync
> with the OS clipboard the moment you copy something outside tmux. `prefix + C-v` always pastes what
> the system clipboard actually holds.

**Plugin Management:**

| Shortcut           | Action                    |
| ------------------ | ------------------------- |
| `prefix + I`       | Install plugins           |
| `prefix + U`       | Update plugins            |
| `prefix + alt + u` | Uninstall removed plugins |

**Optional shortcuts** — these are bound in `tmux.conf.symlink` but depend on helper scripts and
paths that are **not** part of this repo. They do nothing until you provide them:

| Shortcut           | Action                     | Requires                     |
| ------------------ | -------------------------- | ---------------------------- |
| `prefix + D`       | Open `TODO.md` in nvim     | `~/.dotfiles/personal/todo.md` as fallback |
| `prefix + f`       | Session switcher           | `~/.local/bin/tmux-sessionizer` |
| `prefix + i`       | Cheatsheet lookup          | `tmux-cht.sh` on `PATH`      |
| `prefix + G/C/R/H/T/N/S` | Jump to a project    | `~/.local/bin/tmux-sessionizer` and the hardcoded project paths |

### Aerospace (macOS window manager)

Configured in `aerospace/aerospace.toml` → `~/.aerospace.toml`. Tiling layout, no gaps, starts at
login.

**Main mode:**

| Shortcut                  | Action                                  |
| ------------------------- | --------------------------------------- |
| `alt + h/j/k/l`           | Focus window left/down/up/right         |
| `alt + shift + h/j/k/l`   | Move window left/down/up/right          |
| `alt + -` / `alt + =`     | Resize window by −50 / +50              |
| `alt + /`                 | Tiles layout (horizontal/vertical)      |
| `alt + ,`                 | Accordion layout                        |
| `alt + [1-6]`             | Switch to workspace 1–6                 |
| `alt + shift + [1-6]`     | Move window to workspace 1–6            |
| `alt + tab`               | Workspace back-and-forth                |
| `alt + shift + tab`       | Move workspace to next monitor          |
| `alt + shift + ;`         | Enter **service mode**                  |

**Service mode** (entered with `alt + shift + ;`; each action returns to main mode):

| Shortcut                | Action                                   |
| ----------------------- | ---------------------------------------- |
| `esc`                   | Reload Aerospace config                  |
| `r`                     | Reset / flatten workspace tree           |
| `f`                     | Toggle floating ↔ tiling                 |
| `backspace`             | Close all windows but the current one    |
| `alt + shift + h/j/k/l` | Join with window left/down/up/right      |
| `up` / `down`           | Volume up / down                         |
| `shift + down`          | Mute (volume 0)                          |

### skhd (macOS hotkey daemon)

| Shortcut       | Action                    |
| -------------- | ------------------------- |
| `alt + c`      | Open Visual Studio Code   |
| `alt + u`      | Open Google Chrome        |
| `alt + return` | Open Terminal             |

> **⚠️ Not active by default.** `install.sh` starts the skhd *service*, but the line that symlinks
> `skhd/skhdrc.symlink` → `~/.skhdrc` is commented out, so skhd runs with no config and these
> shortcuts do nothing. To enable them:
>
> ```bash
> ln -s ~/.dotfiles/skhd/skhdrc.symlink ~/.skhdrc
> skhd --restart-service
> ```
>
> None of these collide with Aerospace's active bindings, but Aerospace has a commented-out
> `alt-enter` (same physical key as `alt + return`) that also opens Terminal — uncomment it there and
> the two will conflict.

### Zsh

| Shortcut   | Action                 |
| ---------- | ---------------------- |
| `Ctrl + R` | Reverse history search |
| `Tab`      | Auto-completion menu   |

**Aliases:**

| Alias       | Expands to           |
| ----------- | -------------------- |
| `zshconfig` | `$EDITOR ~/.zshrc`   |
| `ohmyzsh`   | `$EDITOR ~/.oh-my-zsh` |

## 🔧 Customization

### Tmux Configuration

Edit `tmux/tmux.conf.symlink` — this is the active config, symlinked to `~/.tmux.conf`.

`tmux/tmux.conf.original.symlink` is an archived copy of the [gpakosz/.tmux](https://github.com/gpakosz/.tmux)
base config, kept only for reference. It is **not** loaded and nothing symlinks to it.

When adding plugins, keep `tmux-continuum` last in the list — see
[Session Persistence](#-session-persistence) for why.

### Adding New Zsh Plugins

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

### Window Management (macOS)

Aerospace bindings, gaps, and layout defaults live in `aerospace/aerospace.toml`. Reload with
`alt + shift + ;` then `esc`, or `aerospace reload-config`.

skhd app shortcuts live in `skhd/skhdrc.symlink` — see the note in
[Key Bindings](#skhd-macos-hotkey-daemon) about enabling it. Reload with `skhd --restart-service`.

### Status Bar Theme

The tmux status bar is [tmux-dotbar](https://github.com/vaaleyard/tmux-dotbar), configured under
"Tmux Dotbar Theme" in `tmux/tmux.conf.symlink` (colors, position, and which side shows the session
name).

## 🐛 Troubleshooting

### Sessions aren't restored after a reboot

1. Check that a recent snapshot exists:

   ```bash
   ls -la ~/.local/share/tmux/resurrect/
   ```

   If `last` points at an old file, autosaving has stopped.

2. Verify continuum's autosave hook is present in `status-right`:

   ```bash
   tmux show-options -gv status-right
   ```

   This must contain `#(.../tmux-continuum/scripts/continuum_save.sh)`. If it is empty, a status-bar
   plugin has overwritten it — make sure `tmux-dotbar` is listed **before** `tmux-continuum` in
   `tmux.conf.symlink`, then run `tmux kill-server` and reopen your terminal.

3. Confirm the plugins are installed:

   ```bash
   ls ~/.tmux/plugins/
   ```

   You should see `tmux-resurrect`, `tmux-continuum`, `tmux-yank`, `tmux-dotbar`, and `tpm`. If not,
   press `prefix + I`.

4. Make sure no halt file is blocking restore:

   ```bash
   rm -f ~/tmux_no_auto_restore
   ```

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

If you see text like `10;rgb:e6e6/eded/f3f3...` in panes, ensure `tmux.conf.symlink` has:

```bash
set -g default-terminal "tmux-256color"
set -g allow-passthrough off
set -g set-clipboard on
set -s escape-time 50
```

Then fully restart tmux:

```bash
tmux kill-server
```

### Copy/paste not working in tmux

1. Confirm the clipboard bindings survived plugin load. They live in the **CLIPBOARD** section at the
   very bottom of `tmux.conf.symlink`, *after* `run tpm`, precisely so tmux-yank cannot overwrite
   them:

   ```bash
   tmux list-keys -T copy-mode-vi | grep ' y '
   ```

   This must show `copy-pipe-and-cancel "pbcopy ..."`. If it shows something else, a plugin won the
   binding — check that the CLIPBOARD section is still last in the file.

2. Verify the clipboard command itself works:

   ```bash
   tmux run-shell "printf test | pbcopy" && pbpaste
   ```

3. Use `prefix + [` to enter copy mode, `v` to select, `y` to copy. Then `pbpaste` to confirm it
   landed.

> **Note:** Do not add copy bindings above the `run tpm` line — tmux-yank silently overrides anything
> bound before it. See [Session Persistence](#-session-persistence) for the same trap breaking
> autosave.

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
- **cmatrix / neofetch** — Terminal eye candy
- **skhd** — Hotkey daemon (macOS)
- **aerospace** — Window manager (macOS)

## 🙏 Credits

- [Oh-My-Zsh](https://ohmyz.sh/)
- [Pure Prompt](https://github.com/sindresorhus/pure)
- [tmux](https://github.com/tmux/tmux)
- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) / [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) / [tmux-yank](https://github.com/tmux-plugins/tmux-yank)
- [tmux-dotbar](https://github.com/vaaleyard/tmux-dotbar)
- [gpakosz/.tmux](https://github.com/gpakosz/.tmux)
- [Aerospace](https://github.com/nikitabobko/AeroSpace)
