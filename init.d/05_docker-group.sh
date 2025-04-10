#!/usr/bin/env bash
set -e

INVOKER="${SUDO_USER:-$USER}"

if ! command -v docker >/dev/null 2>&1; then
  echo "[*] Docker not installed yet. Skipping docker group setup."
  exit 0
fi

echo "[*] Ensuring 'docker' group exists and user is a member..."

if ! getent group docker >/dev/null; then
  echo "[*] Creating docker group..."
  sudo groupadd docker
fi

if ! id -nG "$INVOKER" | grep -qw docker; then
  echo "[*] Adding $INVOKER to docker group..."
  sudo usermod -aG docker "$INVOKER"
  echo "[*] You may need to log out and back in for this to take effect."
fi