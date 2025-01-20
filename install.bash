#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error and exit immediately

# Prompt for sudo password upfront
echo "This script requires administrative privileges. Please enter your password:"
sudo -v

# Keep the sudo session alive during the script execution
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &


echo "Installing Zsh and setting it as the default shell..."

# Install Zsh if not already installed
if ! command -v zsh &>/dev/null; then
  sudo apt update && sudo apt install -y zsh
else
  echo "Zsh is already installed."
fi

# Change the default shell to Zsh
if [ "$(echo $SHELL)" != "/usr/bin/zsh" ]; then
  sudo chsh -s /usr/bin/zsh $(whoami)
  echo "Default shell changed to Zsh."
else
  echo "Zsh is already the default shell."
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/viceo/oh-my-zsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed."
fi

# Define ZSH_CUSTOM and ensure the directory exists
export ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Add custom aliases
echo "Adding custom aliases..."
cat <<EOF > "$ZSH_CUSTOM/aliases.zsh"
alias ll='ls -lh'
alias la='ls -la'
EOF

# Add WSL-specific configurations
if ! grep -q "unsetopt beep" "$HOME/.zshrc"; then
  echo "Configuring WSL-specific settings..."
  cat <<EOF >> "$HOME/.zshrc"

# Mute annoying WSL beep noises
unsetopt beep
EOF
else
  echo "WSL-specific settings already configured."
fi

# Install the Hyperzsh theme
echo "Installing the Hyperzsh theme..."
if [ ! -d "$ZSH_CUSTOM/themes" ]; then
  mkdir -p "$ZSH_CUSTOM/themes"
fi

wget -q -O "$ZSH_CUSTOM/themes/hyperzsh.zsh-theme" https://raw.githubusercontent.com/viceo/hyperzsh/master/hyperzsh.zsh-theme
sed -i 's/^ZSH_THEME="[^"]*"/ZSH_THEME="hyperzsh"/' "$HOME/.zshrc"

# Ensure default starting directory is /home/$(whoami)
if ! grep -q "cd /home/$(whoami)" "$HOME/.zshrc"; then
  echo "Setting default directory to /home/$(whoami)..."
  cat <<EOF >> "$HOME/.zshrc"

# Set default starting directory
cd /home/$(whoami)
EOF
else
  echo "Default directory already set to /home/$(whoami)."
fi

# Install Neofetch
if ! command -v neofetch &>/dev/null; then
  echo "Installing Neofetch..."
  sudo apt update && sudo apt install -y neofetch
else
  echo "Neofetch is already installed."
fi

# Add Neofetch to .zshrc
if ! grep -q "neofetch" "$HOME/.zshrc"; then
  echo "Adding Neofetch to .zshrc..."
  cat <<EOF >> "$HOME/.zshrc"

# Display system information with Neofetch
neofetch
EOF
else
  echo "Neofetch is already configured in .zshrc."
fi

echo "Installation and configuration complete! Restart your terminal or run 'zsh' to apply changes."

