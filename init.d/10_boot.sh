#!/usr/bin/env bash

set -e

echo "[*] Installing cdapkg CLI..."

install -m 0755 ./bin/cdapkg /usr/local/bin/cdapkg
install -d /usr/local/share/cdapkg
cp -r ./share/* /usr/local/share/cdapkg/

install -d /usr/local/etc/cdapkg
cp -r ./etc/* /usr/local/etc/cdapkg/

echo "[+] cdapkg installed!"