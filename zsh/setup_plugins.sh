#!/bin/bash
# ============================================================================
# ZSH PLUGINS SETUP SCRIPT
# ============================================================================
# This script installs and sets up zsh plugins for oh-my-zsh
# ============================================================================

set -e  # Exit on error

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ============================================================================
# VALIDATION
# ============================================================================
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "❌ Oh-My-Zsh not found. Please install Oh-My-Zsh first."
  exit 1
fi

# ============================================================================
# SETUP PLUGINS DIRECTORY
# ============================================================================
echo "📁 Setting up plugins directory..."
mkdir -p "$ZSH_CUSTOM/plugins"

# ============================================================================
# INSTALL ZSH-SYNTAX-HIGHLIGHTING
# ============================================================================
echo "📦 Installing zsh-syntax-highlighting..."
if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "  → Removing existing installation..."
  rm -rf "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# ============================================================================
# MACOS CLIPBOARD SUPPORT
# ============================================================================
if [ "$(uname)" = "Darwin" ]; then
  echo "🍎 Setting up macOS clipboard support..."
  if ! command -v reattach-to-user-namespace &> /dev/null; then
    brew install reattach-to-user-namespace 2>/dev/null || \
      echo "⚠️  Failed to install reattach-to-user-namespace"
  else
    echo "  → Already installed"
  fi
fi

echo "✅ Plugins setup complete!"
