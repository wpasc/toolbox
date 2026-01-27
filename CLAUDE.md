# toolbox - Claude Rules

## Project Overview

A personal workspace for learning, experimenting with, and collecting engineering tools. Current focus: NeoVim and tmux. This repo serves as both a learning journal and a place to store useful configurations, scripts, and reference materials.

## External Standards

Before beginning work, read and follow the standards in:
`../cross_project_ai_resources/agent-context/core/`

These contain universal preferences for documentation and testing.

### Optional Standards (Load When Relevant)

| Standard | Load When |
|----------|-----------|
| `agent-context/conditional/anti-patterns.md` | Code review, architectural decisions |
| `agent-context/conditional/agent-handoff-standard.md` | Multi-agent workflows |

### Session Checkpoints

Checkpoints in `.ai/checkpoints/` preserve session context for work continuation.

| Load When | Skip When |
|-----------|-----------|
| Resuming in-progress work | General repo review or audit |
| Checking current status or next steps | Code review or quality assessment |

## Content Organization

```
configs/       # Dotfiles and configuration (nvim, tmux, etc.)
notes/         # Learning notes organized by topic
scripts/       # Utility scripts and tools
experiments/   # Throwaway explorations and trials
references/    # Links, cheatsheets, external resources
```

## Key Patterns

- **Notes**: Use markdown with clear headings. Date prefix optional.
- **Configs**: Mirror the actual dotfile structure (e.g., `configs/nvim/` for `~/.config/nvim/`)
- **Scripts**: Include a comment header explaining purpose and usage

## Common Workflows

- Adding new notes: Create in `notes/[topic]/` with descriptive filename
- Saving a config: Copy to `configs/[tool]/`, document any dependencies
- Trying something new: Use `experiments/` freely - it's meant for mess
- Finding info: Check `notes/` first, then `references/`

## Current Focus

- NeoVim: Setup, configuration, learning keybindings and plugins
- tmux: Session management, configuration, workflow integration
