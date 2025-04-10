#!/usr/bin/env bash
set -euo pipefail

INSTALL_PATH="/usr/local/cdaprod"
REPO_URL="https://github.com/Cdaprod/cdapkg"
CDAPROD_HOME="$INSTALL_PATH"
INVOKER="${SUDO_USER:-$USER}"

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
  echo "[*] Dry-run mode: no actions will be performed."
  DRY_RUN=true
fi

run() {
  echo "[*] $*"
  if [ "$DRY_RUN" = false ]; then
    eval "$@"
  fi
}

# Clone or update repo
if [ -d "$INSTALL_PATH/.git" ]; then
  echo "[*] Updating cdapkg at $INSTALL_PATH..."
  cd "$INSTALL_PATH"
  if ! git diff-index --quiet HEAD --; then
    echo "[!] Local changes detected -- aborting pull."
    exit 1
  fi
  run "sudo git pull"
else
  echo "[*] Cloning cdapkg to $INSTALL_PATH..."
  run "sudo git clone \"$REPO_URL\" \"$INSTALL_PATH\""
fi

cd "$INSTALL_PATH"

# Make init scripts executable
echo "[*] Ensuring init scripts are executable..."
run "chmod +x init.d/[0-9][0-9]_*.sh"

# Run init sequence
echo "[*] Running cdapkg init sequence..."
for f in init.d/[0-9][0-9]_*.sh; do
  echo "[*] Executing $f"
  if [ "$DRY_RUN" = false ]; then
    bash "$f"
  else
    echo "[*] (dry-run) would execute $f"
  fi
done

echo "[+] cdapkg bootstrap complete."