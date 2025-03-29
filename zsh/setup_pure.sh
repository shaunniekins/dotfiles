#!/bin/bash

# This script installs and sets up Pure prompt for zsh
# Pure prompt: https://github.com/sindresorhus/pure

# Create directories if they don't exist
mkdir -p "$HOME/.zfunctions"

echo "Setting up Pure prompt..."
# Always reinstall the Pure repository
if [ -d "$HOME/.zfunctions/pure" ]; then
  echo "Removing existing Pure prompt installation..."
  rm -rf "$HOME/.zfunctions/pure"
fi

echo "Installing Pure prompt..."
git clone https://github.com/sindresorhus/pure.git "$HOME/.zfunctions/pure"

# Create symlinks to Pure functions in .zfunctions directory
ln -sf "$HOME/.zfunctions/pure/pure.zsh" "$HOME/.zfunctions/prompt_pure_setup"
ln -sf "$HOME/.zfunctions/pure/async.zsh" "$HOME/.zfunctions/async"

# Setup zsh syntax highlighting
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
echo "Setting up zsh syntax highlighting..."
if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Removing existing zsh-syntax-highlighting..."
  rm -rf "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
echo "zsh syntax highlighting setup complete!"

echo "Pure prompt setup complete!"
chmod +x "$0"
