#!/usr/bin/env bash
set -e

INVOKER="${SUDO_USER:-$USER}"
echo "[*] Fixing ownership of /usr/local/cdaprod for user: $INVOKER"
sudo chown -R "$INVOKER:$INVOKER" /usr/local/cdaprod