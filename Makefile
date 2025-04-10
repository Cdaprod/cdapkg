# cdapkg Makefile

PREFIX       ?= /usr/local
BIN_DIR      := $(PREFIX)/bin
SHARE_DIR    := $(PREFIX)/share/cdapkg
MAN_DIR      := $(PREFIX)/share/man/man1
ETC_DIR      := $(PREFIX)/etc/cdapkg
PROFILE_D    := /etc/profile.d
BOOTSTRAP_SH := $(PROFILE_D)/cdapkg.sh

CLI_BINARY   := ./bin/cdapkg
MANPAGE_SRC  := ./share/man/cdapkg.1
INSTALL_SH   := ./scripts/install.sh

.PHONY: help install uninstall reinstall

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install     Install cdapkg CLI tool and assets"
	@echo "  uninstall   Remove cdapkg CLI and all files"
	@echo "  reinstall   Reinstall everything"
	@echo "  help        Show this help message"

install:
	@echo "[*] Installing cdapkg CLI tool..."
	@mkdir -p $(BIN_DIR) $(SHARE_DIR) $(MAN_DIR) $(ETC_DIR)
	install -m 0755 $(CLI_BINARY) $(BIN_DIR)/cdapkg
	cp -rv ./share/* $(SHARE_DIR)/
ifneq ("$(wildcard $(MANPAGE_SRC))","")
	@echo "[*] Installing manpage..."
	install -m 0644 $(MANPAGE_SRC) $(MAN_DIR)/cdapkg.1
	mandb -q || true
endif
ifneq ("$(wildcard ./etc/*)","")
	@echo "[*] Installing configs..."
	cp -rv ./etc/* $(ETC_DIR)/
endif
	@echo "[*] Setting up environment bootstrap..."
	@mkdir -p $(PROFILE_D)
	@echo '#!/usr/bin/env bash' > $(BOOTSTRAP_SH)
	@echo "manpath=\"$(MAN_DIR)\"" >> $(BOOTSTRAP_SH)
	@echo 'if ! grep -q "$$manpath" <<< "$$MANPATH"; then' >> $(BOOTSTRAP_SH)
	@echo '  export MANPATH="$$manpath:$$MANPATH"' >> $(BOOTSTRAP_SH)
	@echo 'fi' >> $(BOOTSTRAP_SH)
	@chmod +x $(BOOTSTRAP_SH)
	@echo "[+] cdapkg installed."

uninstall:
	@echo "[*] Uninstalling cdapkg..."
	@rm -fv $(BIN_DIR)/cdapkg
	@rm -rfv $(SHARE_DIR)
	@rm -rfv $(ETC_DIR)
	@rm -fv $(MAN_DIR)/cdapkg.1
	@rm -fv $(BOOTSTRAP_SH)
	@echo "[+] cdapkg uninstalled."

reinstall: uninstall install