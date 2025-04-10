#!/usr/bin/env bash
set -e

if command -v make >/dev/null 2>&1; then
  echo "[*] make already installed"
  exit 0
fi

echo "[*] Installing 'make' based on distro..."

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
    echo "[!] Unsupported distro: $ID"
    exit 1
    ;;
esac