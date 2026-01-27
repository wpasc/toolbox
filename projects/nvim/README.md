# NeoVim Configuration

Personal NeoVim setup focused on learning fundamentals before customizing.

## Philosophy

- Learn default keybindings where they're sensible
- Override only when ergonomic benefit is clear and obvious
- Understand what each config line does before adding it

## Setup

1. Install NeoVim: `brew install neovim`
2. Symlink config: `ln -sf $(pwd)/config ~/.config/nvim`
3. Launch and let lazy.nvim install plugins: `nvim`

## Current State

Minimal config with:
- [ ] Plugin manager (lazy.nvim)
- [ ] File explorer (nvim-tree)
- [ ] Colorscheme (VS Code-like dark theme)
- [ ] Python LSP support
- [ ] Git blame integration
- [ ] Bookmarks

## Dependencies

- NeoVim 0.9+ (for Lua config support)
- A Nerd Font (for icons in file explorer) - optional but recommended
- Node.js (for some LSP servers)
- Python + pip (for Python LSP)

## Notes

Project-specific notes go in `notes/`. See also `shared/notes/keybindings.md` for cross-tool shortcuts.
