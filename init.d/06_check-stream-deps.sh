#!/usr/bin/env bash
set -e
DEPS=(tmux wf-recorder ffmpeg tree python3)
for bin in "${DEPS[@]}"; do
  if ! command -v "$bin" >/dev/null; then
    echo "[!] Missing dependency: $bin"
  fi
done