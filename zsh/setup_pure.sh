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

echo "Pure prompt setup complete!"
chmod +x "$0"
