#!/usr/bin/env bash

set -e

# Step 1: Check for Homebrew and install if missing
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ $? -ne 0 ]; then
    echo "Homebrew installation failed. Exiting."
    exit 1
  fi
  # Detect Apple Silicon (arm64)
  if [[ $(uname -m) == 'arm64' ]]; then
    echo "If you are on Apple Silicon, add Homebrew to your PATH:"
    echo 'echo "eval $(/opt/homebrew/bin/brew shellenv)" >> ~/.zprofile'
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
  fi
else
  echo "Homebrew is already installed."
fi

# Step 2: Install zsh and Oh My Zsh

# Check if zsh is installed
if ! command -v zsh &>/dev/null; then
  echo "zsh not found. Installing zsh via Homebrew..."
  brew install zsh
  if [ $? -ne 0 ]; then
    echo "zsh installation failed. Exiting."
    exit 1
  fi
else
  echo "zsh is already installed."
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  if [ $? -ne 0 ]; then
    echo "Oh My Zsh installation failed. Exiting."
    exit 1
  fi
else
  echo "Oh My Zsh is already installed."
fi

# Install Powerlevel10k theme for Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k theme for Oh My Zsh..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
  if [ $? -ne 0 ]; then
    echo "Powerlevel10k installation failed. Exiting."
    exit 1
  fi
else
  echo "Powerlevel10k theme is already installed."
fi

echo "To enable Powerlevel10k, set this in your ~/.zshrc (if not already present):"
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"'

# Step 3: Install tree and htop

echo "Installing CLI tools via Homebrew..."
brew install tree htop lazygit zoxide ripgrep fzf gh git git-delta eza bat fd zsh-syntax-highlighting yazi tmux neovim
if [ $? -ne 0 ]; then
  echo "Failed to install one or more CLI tools. Exiting."
  exit 1
fi

echo "All CLI tools have been installed successfully!"

# Install nvm (Node Version Manager)
if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing nvm (Node Version Manager)..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  if [ $? -ne 0 ]; then
    echo "nvm installation failed. Exiting."
    exit 1
  fi
  echo "nvm installed. Please restart your terminal or run:"
  echo '  export NVM_DIR="$HOME/.nvm"'
  echo '  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
else
  echo "nvm is already installed."
fi

echo "\nInstalling GUI apps (casks) via Homebrew..."
brew install --cask nikitabobko/tap/aerospace
if [ $? -ne 0 ]; then
  echo "Failed to install one or more GUI apps (aerospace). Exiting."
  exit 1
fi

echo "All requested CLI tools and GUI apps have been installed successfully!"

echo
if brew list zsh-syntax-highlighting &>/dev/null; then
  echo "To enable zsh-syntax-highlighting, add the following to your ~/.zshrc (if not already present):"
  echo 'source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
fi
