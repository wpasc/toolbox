# toolbox setup
# Usage: make setup         (full install from scratch — macOS with brew)
#        make setup-remote  (remote Linux — no brew, no sudo, no npm)
#        make link          (symlink configs only)
#        make brew          (install packages only)
#        make status        (show what's installed and linked)

SHELL := /bin/bash
TOOLBOX_DIR := $(shell pwd)

# ─── What to install ──────────────────────────────────────────────────────────
# CLI tools installed from GitHub releases (via scripts/install-cli-tool)
CLI_TOOLS := ripgrep fd bat delta fzf neovim

# Brew is only for things without prebuilt binaries + font casks
BREW_PACKAGES := tmux
BREW_CASKS := font-jetbrains-mono-nerd-font

# ─── What to symlink ─────────────────────────────────────────────────────────
# Format: source:target
# Add new config symlinks here as you add tools
# Note: Cursor symlinks handled separately (link-cursor) due to spaces in path
SYMLINKS := \
	active/nvim:$(HOME)/.config/nvim \
	active/tmux/tmux.conf:$(HOME)/.tmux.conf

CURSOR_USER_DIR := $(HOME)/Library/Application Support/Cursor/User

# ─── Targets ──────────────────────────────────────────────────────────────────

.PHONY: setup setup-remote install-cli-tools force-install-cli-tools brew link link-cursor nvim-plugins tmux-plugins configure-cli-tools cursor-extensions cursor-extensions-install status clean help

## Full setup from scratch
setup: install-cli-tools brew link link-cursor nvim-plugins tmux-plugins configure-cli-tools
	@echo ""
	@echo "✅ Setup complete!"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Ensure ~/.local/bin is in your PATH:"
	@echo "     export PATH=\"\$$HOME/.local/bin:\$$PATH\""
	@echo "  2. Set your terminal font to 'JetBrainsMono Nerd Font'"
	@echo "  3. Restart your terminal"
	@echo "  4. Run: tmux new -s main"
	@echo "  5. Run: nvim"

## Setup for remote Linux machines (no brew, no sudo, no npm)
setup-remote: install-cli-tools link nvim-plugins tmux-plugins configure-cli-tools
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
	@echo "Note: tmux must be installed separately on remote (system package manager)."
	@echo "      markdown-preview (browser) is skipped without npm."
	@echo "      render-markdown (in-buffer) works without it."

## Install CLI tools from GitHub releases to ~/.local/bin
install-cli-tools:
	@echo "── Installing CLI tools from GitHub releases ──"
	@mkdir -p $(HOME)/.local/bin
	@for tool in $(CLI_TOOLS); do \
		bash $(TOOLBOX_DIR)/scripts/install-cli-tool "$$tool"; \
	done

## Force-reinstall all CLI tools (re-downloads latest)
force-install-cli-tools:
	@echo "── Force-installing CLI tools ──"
	@mkdir -p $(HOME)/.local/bin
	@for tool in $(CLI_TOOLS); do \
		bash $(TOOLBOX_DIR)/scripts/install-cli-tool "$$tool" --force; \
	done

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

## Symlink Cursor configs
link-cursor:
	@echo "── Symlinking Cursor configs ──"
	@mkdir -p "$(CURSOR_USER_DIR)"
	@for file in settings.json keybindings.json; do \
		dst="$(CURSOR_USER_DIR)/$$file"; \
		src="$(TOOLBOX_DIR)/active/cursor/$$file"; \
		if [ -L "$$dst" ]; then \
			echo "  relink $$dst -> $$src"; \
			rm "$$dst"; \
		elif [ -e "$$dst" ]; then \
			echo "  backup $$dst -> $$dst.bak"; \
			mv "$$dst" "$$dst.bak"; \
		else \
			echo "  link   $$dst -> $$src"; \
		fi; \
		ln -sf "$$src" "$$dst"; \
	done

## Configure CLI tools (delta as git pager, fzf shell integration)
configure-cli-tools:
	@echo "── Configuring CLI tools ──"
	@if command -v delta >/dev/null 2>&1; then \
		echo "  Configuring delta as git pager..."; \
		git config --global core.pager delta; \
		git config --global interactive.diffFilter "delta --color-only"; \
		git config --global delta.navigate true; \
		git config --global delta.dark true; \
		git config --global delta.side-by-side true; \
		git config --global delta.line-numbers true; \
		git config --global delta.syntax-theme "Visual Studio Dark+"; \
		git config --global merge.conflictstyle diff3; \
		git config --global diff.colorMoved default; \
		echo "  delta configured"; \
	else \
		echo "  delta not found, skipping"; \
	fi
	@if command -v fzf >/dev/null 2>&1; then \
		echo "  fzf installed — add to your .zshrc:"; \
		echo "    source <(fzf --zsh)"; \
		echo "  Or for bash:"; \
		echo "    eval \"\$$(fzf --bash)\""; \
	else \
		echo "  fzf not found, skipping"; \
	fi

## Install nvim plugins (headless)
nvim-plugins:
	@echo "── Installing nvim plugins ──"
	nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
	@echo "  done"

## Install tmux plugins (TPM)
tmux-plugins:
	@echo "── Installing tmux plugins ──"
	@if [ ! -d "$(HOME)/.tmux/plugins/tpm" ]; then \
		echo "  Cloning TPM..."; \
		git clone https://github.com/tmux-plugins/tpm "$(HOME)/.tmux/plugins/tpm"; \
	else \
		echo "  TPM already installed"; \
	fi
	@echo "  Installing plugins..."
	@tmux start-server \; set-environment -g TMUX_PLUGIN_MANAGER_PATH "$(HOME)/.tmux/plugins/" \; source-file "$(HOME)/.tmux.conf" 2>/dev/null; \
		$(HOME)/.tmux/plugins/tpm/bin/install_plugins; \
		tmux kill-server 2>/dev/null || true
	@echo "  done"

## Export installed Cursor extensions to active/cursor/extensions.txt
cursor-extensions:
	@echo "── Exporting Cursor extensions ──"
	@if command -v cursor >/dev/null 2>&1; then \
		cursor --list-extensions > active/cursor/extensions.txt; \
		echo "  Saved to active/cursor/extensions.txt"; \
	else \
		echo "  cursor CLI not found, skipping"; \
	fi

## Install Cursor extensions from active/cursor/extensions.txt
cursor-extensions-install:
	@echo "── Installing Cursor extensions ──"
	@if command -v cursor >/dev/null 2>&1; then \
		while read ext; do \
			cursor --install-extension "$$ext"; \
		done < active/cursor/extensions.txt; \
	else \
		echo "  cursor CLI not found, skipping"; \
	fi

## Show what's installed and linked
status:
	@echo "── CLI tools ──"
	@for tool in $(CLI_TOOLS); do \
		bin=$$tool; \
		case $$tool in ripgrep) bin=rg;; neovim) bin=nvim;; esac; \
		if command -v "$$bin" >/dev/null 2>&1; then \
			echo "  ✅ $$tool ($$($$bin --version 2>/dev/null | head -1))"; \
		else \
			echo "  ❌ $$tool (not installed)"; \
		fi; \
	done
	@echo "── Brew packages ──"
	@for pkg in $(BREW_PACKAGES); do \
		if command -v "$$pkg" >/dev/null 2>&1; then \
			echo "  ✅ $$pkg ($$($$pkg -V 2>/dev/null | head -1))"; \
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
	@echo "── Cursor symlinks ──"
	@for file in settings.json keybindings.json; do \
		dst="$(CURSOR_USER_DIR)/$$file"; \
		if [ -L "$$dst" ]; then \
			echo "  ✅ $$dst -> $$(readlink "$$dst")"; \
		elif [ -e "$$dst" ]; then \
			echo "  ⚠️  $$dst (exists but not a symlink)"; \
		else \
			echo "  ❌ $$dst (missing)"; \
		fi; \
	done
	@echo "── Tmux plugins (TPM) ──"
	@if [ -d "$(HOME)/.tmux/plugins/tpm" ]; then \
		echo "  ✅ TPM"; \
		for dir in $(HOME)/.tmux/plugins/*/; do \
			name=$$(basename "$$dir"); \
			if [ "$$name" != "tpm" ]; then \
				echo "  ✅ $$name"; \
			fi; \
		done; \
	else \
		echo "  ❌ TPM (not installed — run: make tmux-plugins)"; \
	fi
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
	@echo "── Removing Cursor symlinks ──"
	@for file in settings.json keybindings.json; do \
		dst="$(CURSOR_USER_DIR)/$$file"; \
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
