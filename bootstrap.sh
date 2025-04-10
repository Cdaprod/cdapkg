#!/usr/bin/env bash
set -euo pipefail

CDAPROD_HOME="$INSTALL_PATH"
REPO_URL="https://github.com/Cdaprod/cdapkg"
INSTALL_PATH="/usr/local/cdaprod"
INVOKER="${SUDO_USER:-$USER}"

# Clone or update
if [ -d "$INSTALL_PATH/.git" ]; then
  echo "[*] Updating cdapkg at $INSTALL_PATH..."
  sudo git -C "$INSTALL_PATH" pull
else
  echo "[*] Cloning cdapkg to $INSTALL_PATH..."
  sudo git clone "$REPO_URL" "$INSTALL_PATH"
fi

cd "$INSTALL_PATH"

# Ensure init scripts are executable
chmod +x init.d/[0-9][0-9]_*.sh

echo "[*] Running cdapkg init sequence..."
for f in init.d/[0-9][0-9]_*.sh; do
  echo "[*] Executing $f"
  bash "$f"
done

echo "[+] cdapkg bootstrap complete"