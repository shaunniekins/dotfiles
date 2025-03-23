#!/bin/bash

# This script installs and sets up zsh plugins

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
CURRENT_DIR=$(pwd)

# Check if Oh-My-Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh-My-Zsh not found. Please install Oh-My-Zsh first."
  exit 1
fi

# Ensure the plugins directory exists
mkdir -p "$ZSH_CUSTOM/plugins"

# Install/reinstall zsh-autosuggestions
echo "Installing/reinstalling zsh-autosuggestions..."
if [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  rm -rf "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

# Install/reinstall zsh-syntax-highlighting
echo "Installing/reinstalling zsh-syntax-highlighting..."
if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  rm -rf "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# Install reattach-to-user-namespace for macOS clipboard support
if [ "$(uname)" = "Darwin" ]; then
  echo "Installing reattach-to-user-namespace for clipboard support..."
  brew install reattach-to-user-namespace 2>/dev/null || echo "Failed to install reattach-to-user-namespace, please install manually"
fi

echo "Plugins setup complete! Run 'source ~/.zshrc' to apply changes."
chmod +x "$0"
