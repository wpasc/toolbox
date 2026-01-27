# Keybindings Reference

A living document tracking shortcuts worth remembering, organized by tool.
Includes both defaults being learned and deliberate overrides.

---

## Legend

- `C-x` = Ctrl + x
- `M-x` = Alt/Option + x (Meta)
- `<leader>` = Space (in our NeoVim config)
- **DEFAULT** = keeping the standard binding
- **OVERRIDE** = changed from default (rationale noted)

---

## Vim/NeoVim

### Movement (DEFAULT - worth committing to muscle memory)

| Key | Action | Notes |
|-----|--------|-------|
| `h` `j` `k` `l` | Left, Down, Up, Right | The fundamentals |
| `w` | Next word start | |
| `b` | Previous word start | |
| `e` | End of word | |
| `0` | Start of line | |
| `^` | First non-blank character | |
| `$` | End of line | |
| `gg` | Go to file start | |
| `G` | Go to file end | |
| `{` `}` | Previous/next paragraph | |
| `C-d` | Half-page down | **Consider override to C-j** |
| `C-u` | Half-page up | **Consider override to C-k** |

### Editing (DEFAULT)

| Key | Action | Notes |
|-----|--------|-------|
| `i` | Insert before cursor | |
| `a` | Insert after cursor | |
| `I` | Insert at line start | |
| `A` | Insert at line end | |
| `o` | New line below | |
| `O` | New line above | |
| `x` | Delete character | |
| `dd` | Delete line | |
| `yy` | Yank (copy) line | |
| `p` | Paste after | |
| `P` | Paste before | |
| `u` | Undo | |
| `C-r` | Redo | |
| `.` | Repeat last change | Very powerful |

### Search (DEFAULT)

| Key | Action | Notes |
|-----|--------|-------|
| `/pattern` | Search forward | |
| `?pattern` | Search backward | |
| `n` | Next match | Centered in our config |
| `N` | Previous match | Centered in our config |
| `*` | Search word under cursor | |
| `#` | Search word under cursor (backward) | |

### Windows/Splits (DEFAULT)

| Key | Action | Notes |
|-----|--------|-------|
| `C-w s` | Split horizontal | |
| `C-w v` | Split vertical | |
| `C-w h/j/k/l` | Navigate splits | |
| `C-w q` | Close split | |
| `C-w =` | Equalize split sizes | |

### Our Custom Keymaps

| Key | Action | Notes |
|-----|--------|-------|
| `<leader>e` | Toggle file explorer | NvimTree |
| `<leader>o` | Focus file explorer | |
| `<leader>ff` | Find files | Telescope |
| `<leader>fg` | Live grep | Telescope |
| `<leader>fb` | Find buffers | Telescope |
| `<leader>fr` | Find references | Telescope + LSP |
| `<leader>gb` | Toggle git blame | Gitsigns |
| `<Esc>` | Clear search highlight | In normal mode |

---

## tmux

### Session Management (DEFAULT)

| Key | Action | Notes |
|-----|--------|-------|
| `C-b d` | Detach from session | |
| `C-b s` | List sessions | |
| `C-b $` | Rename session | |

### Windows (DEFAULT)

| Key | Action | Notes |
|-----|--------|-------|
| `C-b c` | Create window | |
| `C-b n` | Next window | |
| `C-b p` | Previous window | |
| `C-b 0-9` | Go to window N | |
| `C-b ,` | Rename window | |
| `C-b &` | Kill window | |

### Panes

| Key | Action | Notes |
|-----|--------|-------|
| `C-b \|` | Split vertical | **OVERRIDE** from `%` |
| `C-b -` | Split horizontal | **OVERRIDE** from `"` |
| `C-b h/j/k/l` | Navigate panes | Added vim-style |
| `C-b x` | Kill pane | DEFAULT |
| `C-b z` | Toggle pane zoom | DEFAULT - very useful |
| `C-b {` `}` | Swap pane position | DEFAULT |
| `C-b Space` | Cycle pane layouts | DEFAULT |

### Other (DEFAULT)

| Key | Action | Notes |
|-----|--------|-------|
| `C-b r` | Reload config | **ADDED** for convenience |
| `C-b [` | Enter copy mode | Then vim keys to navigate |
| `C-b ?` | Show all keybindings | Helpful reference |

---

## Terminal / Readline (Bash/Zsh)

These work in your shell and many other places. Worth knowing.

| Key | Action | Notes |
|-----|--------|-------|
| `C-a` | Beginning of line | Why we kept C-b as tmux prefix |
| `C-e` | End of line | |
| `C-w` | Delete word backward | |
| `C-u` | Delete to line start | |
| `C-k` | Delete to line end | |
| `C-r` | Reverse search history | Very powerful |
| `C-l` | Clear screen | |

---

## Overrides Log

Track what we've changed and why, so future-you understands the reasoning.

| Tool | Default | Override | Rationale |
|------|---------|----------|-----------|
| tmux | `%` split vertical | `\|` | Visual mnemonic, no shift key |
| tmux | `"` split horizontal | `-` | Visual mnemonic, no shift key |
| nvim | (none) | `<Esc>` clears highlight | Common need, intuitive key |
| nvim | `n`/`N` | Added `zz` centering | Keep search result visible |

---

## To Learn / Struggling With

Track bindings you keep forgetting here. Review periodically.

- [ ] ...
- [ ] ...
