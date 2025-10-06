#!/bin/sh
# ============================================================================
# DOTFILES INSTALLATION SCRIPT
# ============================================================================
# This script installs and configures:
# - Package requirements (neovim, tmux, zsh, etc.)
# - Oh-my-zsh with plugins
# - Pure prompt
# - Configuration files via symlinks
# - skhd and Aerospace (macOS only)
# ============================================================================

DOTFILES=$HOME/.dotfiles
BACKUP_DIR=$HOME/dotfiles-backup

# Function to ask for user confirmation
confirm() {
    read -p "$1 (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

echo "=============================="
echo -e "\n\nBackup existing config ..."
echo "=============================="
echo "Creating backup directory at $BACKUP_DIR"
mkdir -p $BACKUP_DIR

# Option to override existing configuration
if confirm "Would you like to override existing configuration files (This will remove existing files before creating symlinks)?"; then
    OVERRIDE_EXISTING=true
    echo "Will override existing configuration files."
else
    OVERRIDE_EXISTING=false
    echo "Will backup existing configuration files."
fi

linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )

# backup up any existing dotfiles in ~ and symlink new ones from .dotfiles
for file in $linkables; do
    filename=".$( basename $file '.symlink' )"
    target="$HOME/$filename"
    if [ -f $target ]; then
        if [ "$OVERRIDE_EXISTING" = true ]; then
            echo "removing existing $filename"
            rm $target
        else
            echo "backing up $filename"
            cp $target $BACKUP_DIR
        fi
    else
        echo -e "$filename does not exist at this location or is a symlink"
    fi
done

echo "=============================="
echo -e "\n\nInstalling packages ..."
echo "=============================="

package_to_install="
    neovim
    cmatrix
    neofetch
    tmux
    tree
    wget
    zsh
    curl
    koekeishiya/formulae/skhd
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
    
    echo "================================================="
    echo "Installing Aerospace window manager on Mac OS"
    echo "================================================="
    brew install --cask nikitabobko/tap/aerospace
 else
    echo "OS NOT DETECTED, couldn't install package $package_to_install"
    exit 1;
 fi


# Start skhd services
if uname -s | grep Darwin; then
    skhd --start-service
fi


echo "================================================="
echo "Installing Oh-my-zsh"
echo "================================================="
# Remove existing Oh-My-Zsh installation if it exists
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Removing existing Oh-My-Zsh installation..."
    rm -rf "$HOME/.oh-my-zsh"
fi
# Install Oh-My-Zsh fresh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch


echo "================================================="
echo "Installing zsh plugins"
echo "================================================="
# Execute the plugin setup script
bash $DOTFILES/zsh/setup_plugins.sh

# Install Pure prompt
echo "================================================="
echo "Installing Pure prompt"
echo "================================================="
# Execute Pure setup script with proper environment
bash $DOTFILES/zsh/setup_pure.sh
# Verify Pure prompt is installed correctly
if [ ! -f "$HOME/.zfunctions/prompt_pure_setup" ]; then
    echo "Warning: Pure prompt setup failed. Installing directly..."
    mkdir -p "$HOME/.zfunctions"
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zfunctions/pure"
    ln -sf "$HOME/.zfunctions/pure/pure.zsh" "$HOME/.zfunctions/prompt_pure_setup"
    ln -sf "$HOME/.zfunctions/pure/async.zsh" "$HOME/.zfunctions/async"
fi

echo "================================================="
echo "Symlinking configuration files"
echo "================================================="

# Function to create a symlink, removing the target if it exists
create_symlink() {
    local source=$1
    local target=$2
    
    # Remove existing file or symlink if OVERRIDE_EXISTING is true
    if [ "$OVERRIDE_EXISTING" = true ] && [ -e "$target" ]; then
        echo "Removing existing $target"
        rm -f "$target"
    fi
    
    # Create the symlink
    if [ ! -e "$target" ]; then
        echo "Creating symlink: $target -> $source"
        ln -s $source $target
    else
        echo "Skipping $target (already exists)"
    fi
}

# Create symlinks for zsh
create_symlink $DOTFILES/zsh/zshrc.symlink $HOME/.zshrc
create_symlink $DOTFILES/zsh/zprofile.symlink $HOME/.zprofile

# Create symlinks for skhd
create_symlink $DOTFILES/skhd/skhdrc.symlink $HOME/.skhdrc

# Create symlink for tmux configuration
create_symlink $DOTFILES/tmux/tmux.conf.symlink $HOME/.tmux.conf
create_symlink $DOTFILES/tmux/tmux.conf.local.symlink $HOME/.tmux.conf.local


# Create symlink for Aerospace on macOS
if uname -s | grep Darwin; then
    create_symlink $DOTFILES/aerospace/aerospace.toml $HOME/.aerospace.toml
fi

# Set zsh as default shell
chsh -s /bin/zsh

# Restart services to apply new configs on macOS
if uname -s | grep Darwin; then
    echo "================================================="
    echo "Starting macOS services..."
    echo "================================================="
    
    # Restart skhd service
    skhd --restart-service
    echo "✓ skhd restarted"
    
    # Start Aerospace application
    if [ -d "/Applications/AeroSpace.app" ]; then
        echo "Starting Aerospace..."
        open -a AeroSpace
        echo "✓ Aerospace started"
    else
        echo "⚠️  Aerospace app not found in /Applications"
        echo "   You may need to start it manually: open -a AeroSpace"
    fi
fi

echo "================================================="
echo "Installation complete!"
echo "================================================="