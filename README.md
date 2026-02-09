# toolbox

A personal workspace for learning and collecting engineering tools. Currently focused on mastering NeoVim and tmux for a better terminal-based development workflow.

## Quick Start

```bash
# Full setup from scratch (brew packages, symlinks, nvim plugins)
make setup

# Just check what's installed
make status
```

See `make help` for all available targets.

## Structure

```
Makefile       # One-command setup for new machines
projects/      # Self-contained tools and workflows
  nvim/        #   NeoVim setup and learning
  tmux/        #   tmux configuration and workflow
shared/        # Cross-project resources
  scripts/     #   Utilities useful across projects
  references/  #   Cheatsheets, links, external resources
  notes/       #   General learning notes (incl. keybindings.md)
experiments/   # Throwaway explorations
```

## Current Projects

- **nvim** - Modal editing, configuration, plugins
- **tmux** - Terminal multiplexing, session management

## For AI Agents

Read [CLAUDE.md](./CLAUDE.md) for complete development guidelines.
