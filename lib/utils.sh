#!/usr/bin/env bash
# Utility functions for cdapkg

# Check if a dependency is installed; output warning if not.
check_dependency() {
  if ! command -v "$1" >/dev/null 2>&1; then
    warn "Dependency '$1' is missing."
  else
    info "Dependency '$1' is installed."
  fi
}

# Ensure a directory exists; if not, create it.
ensure_dir() {
  if [ ! -d "$1" ]; then
    info "Creating directory $1"
    mkdir -p "$1"
  fi
}