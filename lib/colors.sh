#!/usr/bin/env bash
# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'  # No Color

info() {
  echo -e "${CYAN}[*] $1${NC}"
}

success() {
  echo -e "${GREEN}[+] $1${NC}"
}

warn() {
  echo -e "${YELLOW}[!] $1${NC}"
}

error() {
  echo -e "${RED}[✗] $1${NC}" >&2
  exit 1
}