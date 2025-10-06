#!/bin/bash
# ============================================================================
# PURE PROMPT SETUP SCRIPT
# ============================================================================
# This script installs Pure prompt for zsh
# Pure prompt: https://github.com/sindresorhus/pure
# ============================================================================

set -e  # Exit on error

PURE_DIR="$HOME/.zfunctions/pure"
ZFUNCTIONS_DIR="$HOME/.zfunctions"

# ============================================================================
# SETUP DIRECTORIES
# ============================================================================
echo "📁 Setting up directories..."
mkdir -p "$ZFUNCTIONS_DIR"

# ============================================================================
# INSTALL PURE PROMPT
# ============================================================================
echo "🎨 Installing Pure prompt..."
if [ -d "$PURE_DIR" ]; then
  echo "  → Removing existing installation..."
  rm -rf "$PURE_DIR"
fi

git clone https://github.com/sindresorhus/pure.git "$PURE_DIR"

# ============================================================================
# CREATE SYMLINKS
# ============================================================================
echo "🔗 Creating symlinks..."
ln -sf "$PURE_DIR/pure.zsh" "$ZFUNCTIONS_DIR/prompt_pure_setup"
ln -sf "$PURE_DIR/async.zsh" "$ZFUNCTIONS_DIR/async"

echo "✅ Pure prompt setup complete!"
