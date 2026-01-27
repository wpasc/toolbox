# tmux Configuration

Personal tmux setup for session management and terminal multiplexing.

## Philosophy

- Keep default prefix (Ctrl-b) until friction proves otherwise
- Remap awkward defaults (like `%` and `"` for splits) to intuitive alternatives
- Learn the tool before over-customizing

## Setup

1. Install tmux: `brew install tmux`
2. Symlink config:
   ```bash
   ln -sf $(pwd)/config/tmux.conf ~/.tmux.conf
   ```
3. Reload config (if tmux running): `tmux source-file ~/.tmux.conf`

## Core Concepts

- **Session**: A collection of windows. Persists even when you detach.
- **Window**: A full-screen tab within a session.
- **Pane**: A split within a window.
- **Prefix**: The attention key (Ctrl-b) that tells tmux "this command is for you."

## Current State

Minimal config with:
- [x] Default prefix (Ctrl-b)
- [x] Intuitive split bindings (`|` and `-`)
- [x] Vim-style pane navigation (h/j/k/l after prefix)
- [ ] Better status bar
- [ ] Session management helpers

## Notes

Project-specific notes go in `notes/`. See also `shared/notes/keybindings.md` for cross-tool shortcuts.
