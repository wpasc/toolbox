# toolbox

A personal workspace for learning and collecting engineering tools. Currently focused on NeoVim, tmux, and Cursor.

## Quick Start

```bash
# Full setup from scratch (brew packages, symlinks, nvim plugins, cursor configs)
make setup

# Just check what's installed
make status
```

See `make help` for all available targets.

## Structure

```
Makefile         # One-command setup for new machines
active/          # Actively used tool configs
  nvim/          #   NeoVim config and learning
  tmux/          #   tmux configuration
  cursor/        #   Cursor settings and extensions
experimental/    # Tools under evaluation
  dictation/     #   Dictation tooling
scripts/         # Standalone utilities (git-sync, etc.)
notes/           # Cross-cutting learning notes
```

## Active Tools

- **nvim** - Modal editing, configuration, plugins
- **tmux** - Terminal multiplexing, session management
- **cursor** - AI-assisted editor, settings tracking

## For AI Agents

Read [CLAUDE.md](./CLAUDE.md) for complete development guidelines.
