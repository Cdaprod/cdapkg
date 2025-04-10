#!/usr/bin/env bash
set -e

echo "[*] Ensuring 'make' is available..."

if ! command -v make >/dev/null 2>&1; then
  echo "[*] 'make' not found. Attempting to install based on distro..."

  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
      ubuntu|debian|raspbian)
        sudo apt update && sudo apt install -y make
        ;;
      arch|manjaro)
        sudo pacman -Sy --noconfirm make
        ;;
      alpine)
        sudo apk add make
        ;;
      *)
        echo "[!] Unsupported distro: $ID. Please install 'make' manually." >&2
        exit 1
        ;;
    esac
  else
    echo "[!] Cannot detect OS type. Please install 'make' manually." >&2
    exit 1
  fi
else
  echo "[+] 'make' is already installed."
fi

echo "[*] Running 'make install' to finalize cdapkg setup..."
sudo make install