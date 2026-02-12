# NeoVim Configuration

Personal NeoVim setup focused on learning fundamentals before customizing.

## Philosophy

- Learn default keybindings where they're sensible
- Override only when ergonomic benefit is clear and obvious
- Understand what each config line does before adding it

## Setup

Run `make setup` from the repo root, or manually:

1. Install NeoVim: `brew install neovim`
2. Install a Nerd Font: `brew install --cask font-jetbrains-mono-nerd-font`
3. Set your terminal font to "JetBrainsMono Nerd Font"
4. Symlink config: `ln -sf $(pwd)/config ~/.config/nvim`
5. Launch and let lazy.nvim install plugins: `nvim`

## Current State

- [x] Plugin manager (lazy.nvim)
- [x] File explorer (nvim-tree)
- [x] Colorscheme (VS Code dark theme)
- [x] Fuzzy finder (telescope)
- [x] Syntax highlighting (treesitter)
- [x] Git integration (gitsigns + diffview)
- [x] Status line (lualine)
- [x] Markdown rendering — inline (`<leader>mr`) and browser preview (`<leader>mp`)
- [ ] Python LSP support
- [ ] Autocompletion (nvim-cmp)
- [ ] Linting (ruff)
- [ ] Bookmarks

## Dependencies

- NeoVim 0.11+ (for current treesitter API)
- A Nerd Font (for icons in file explorer and status bar)
- Node.js (for markdown-preview.nvim)

## Notes

Project-specific notes go in `notes/`. See also `shared/notes/keybindings.md` for cross-tool shortcuts.
