#!/usr/bin/env bash
set -e

# Check if zsh is installed
if ! command -v zsh >/dev/null 2>&1; then
  echo "[*] zsh is not installed. Attempting to install..."
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
      ubuntu|debian|raspbian)
        sudo apt update && sudo apt install -y zsh
        ;;
      arch|manjaro)
        sudo pacman -Sy --noconfirm zsh
        ;;
      alpine)
        sudo apk add zsh
        ;;
      *)
        echo "[!] Unsupported distro. Please install zsh manually."
        exit 1
        ;;
    esac
  fi
else
  echo "[+] zsh is already installed."
fi

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "[*] Installing Oh My Zsh (unattended)..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "[*] Oh My Zsh is already installed."
fi

# Auto-patch or create a simple ~/.zshrc if not present
ZSHRC="$HOME/.zshrc"
if ! grep -q "ZSH_THEME" "$ZSHRC" 2>/dev/null; then
  echo "[*] Creating default .zshrc..."
  cat <<'EOF' > "$ZSHRC"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
EOF
else
  echo "[*] .zshrc already appears configured."
fi

# Switch default shell to zsh if not already
CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" != "zsh" ]; then
  echo "[*] Changing default shell to zsh for user $USER..."
  chsh -s "$(command -v zsh)"
fi

echo "[+] zsh setup complete."