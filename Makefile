# toolbox setup
# Usage: make setup         (full install from scratch — macOS with brew)
#        make setup-remote  (remote Linux — no brew, no sudo, no npm)
#        make link          (symlink configs only)
#        make brew          (install packages only)
#        make status        (show what's installed and linked)

SHELL := /bin/bash
TOOLBOX_DIR := $(shell pwd)

# ─── What to install ──────────────────────────────────────────────────────────
# Add new brew packages here as your setup evolves
BREW_PACKAGES := neovim tmux
BREW_CASKS := font-jetbrains-mono-nerd-font

# ─── What to symlink ─────────────────────────────────────────────────────────
# Format: source:target
# Add new config symlinks here as you add tools
SYMLINKS := \
	projects/nvim/config:$(HOME)/.config/nvim \
	projects/tmux/config/tmux.conf:$(HOME)/.tmux.conf

# ─── Targets ──────────────────────────────────────────────────────────────────

.PHONY: setup setup-remote install-nvim-remote brew link nvim-plugins status clean help

## Full setup from scratch
setup: brew link nvim-plugins
	@echo ""
	@echo "✅ Setup complete!"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Set your terminal font to 'JetBrainsMono Nerd Font'"
	@echo "  2. Restart your terminal"
	@echo "  3. Run: tmux new -s main"
	@echo "  4. Run: nvim"

## Setup for remote Linux machines (no brew, no sudo, no npm)
setup-remote: install-nvim-remote link nvim-plugins
	@echo ""
	@echo "✅ Remote setup complete!"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Ensure ~/.local/bin is in your PATH:"
	@echo "     echo 'export PATH=\"\$$HOME/.local/bin:\$$PATH\"' >> ~/.bashrc"
	@echo "  2. Restart your shell or: source ~/.bashrc"
	@echo "  3. Run: tmux new -s main"
	@echo "  4. Run: nvim"
	@echo ""
	@echo "Note: markdown-preview (browser) is skipped without npm."
	@echo "      render-markdown (in-buffer) works without it."

## Install neovim on Linux without a package manager
install-nvim-remote:
	@echo "── Installing neovim ──"
	@mkdir -p $(HOME)/.local/bin $(HOME)/.local/share
	@if command -v nvim >/dev/null 2>&1; then \
		echo "  nvim already available: $$(nvim --version | head -1)"; \
		echo "  (remove it or adjust PATH to reinstall)"; \
	else \
		echo "  Downloading nvim..."; \
		curl -Lo /tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz; \
		tar xzf /tmp/nvim.tar.gz -C $(HOME)/.local/share; \
		ln -sf $(HOME)/.local/share/nvim-linux-x86_64/bin/nvim $(HOME)/.local/bin/nvim; \
		rm /tmp/nvim.tar.gz; \
		echo "  Installed to ~/.local/bin/nvim"; \
	fi

## Install brew packages and casks
brew:
	@echo "── Installing brew packages ──"
	@command -v brew >/dev/null || (echo "Error: Homebrew not installed. See https://brew.sh" && exit 1)
	brew install $(BREW_PACKAGES)
	@echo "── Installing brew casks (fonts, apps) ──"
	brew install --cask $(BREW_CASKS) 2>/dev/null || true

## Symlink config files to their expected locations
link:
	@echo "── Symlinking configs ──"
	@for pair in $(SYMLINKS); do \
		src=$${pair%%:*}; \
		dst=$${pair##*:}; \
		mkdir -p "$$(dirname "$$dst")"; \
		if [ -L "$$dst" ]; then \
			echo "  relink $$dst -> $$src"; \
			rm "$$dst"; \
		elif [ -e "$$dst" ]; then \
			echo "  backup $$dst -> $$dst.bak"; \
			mv "$$dst" "$$dst.bak"; \
		else \
			echo "  link   $$dst -> $$src"; \
		fi; \
		ln -sf "$(TOOLBOX_DIR)/$$src" "$$dst"; \
	done

## Install nvim plugins (headless)
nvim-plugins:
	@echo "── Installing nvim plugins ──"
	nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
	@echo "  done"

## Show what's installed and linked
status:
	@echo "── Brew packages ──"
	@for pkg in $(BREW_PACKAGES); do \
		if command -v "$$pkg" >/dev/null 2>&1; then \
			echo "  ✅ $$pkg ($$($$pkg --version 2>/dev/null | head -1))"; \
		else \
			echo "  ❌ $$pkg (not installed)"; \
		fi; \
	done
	@echo "── Symlinks ──"
	@for pair in $(SYMLINKS); do \
		dst=$${pair##*:}; \
		if [ -L "$$dst" ]; then \
			echo "  ✅ $$dst -> $$(readlink "$$dst")"; \
		elif [ -e "$$dst" ]; then \
			echo "  ⚠️  $$dst (exists but not a symlink)"; \
		else \
			echo "  ❌ $$dst (missing)"; \
		fi; \
	done
	@echo "── Font ──"
	@if fc-list 2>/dev/null | grep -qi "JetBrainsMono Nerd" || ls ~/Library/Fonts/*JetBrainsMono*Nerd* >/dev/null 2>&1; then \
		echo "  ✅ JetBrainsMono Nerd Font"; \
	else \
		echo "  ❌ JetBrainsMono Nerd Font (not found — set terminal font after install)"; \
	fi

## Remove symlinks (does not uninstall packages)
clean:
	@echo "── Removing symlinks ──"
	@for pair in $(SYMLINKS); do \
		dst=$${pair##*:}; \
		if [ -L "$$dst" ]; then \
			echo "  remove $$dst"; \
			rm "$$dst"; \
			if [ -e "$$dst.bak" ]; then \
				echo "  restore $$dst.bak -> $$dst"; \
				mv "$$dst.bak" "$$dst"; \
			fi; \
		fi; \
	done

## Show this help
help:
	@echo "Usage: make [target]"
	@echo ""
	@grep -E '^## ' $(MAKEFILE_LIST) | sed 's/## //' | paste - - | awk -F'\t' '{printf "  %-20s %s\n", $$2, $$1}'
