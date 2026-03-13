# toolbox - Claude Rules

## Project Overview

A personal workspace for learning, experimenting with, and collecting engineering tools. Current focus: NeoVim, tmux, and Cursor. This repo serves as both a learning journal and a place to store useful configurations, scripts, and reference materials.

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
active/             # Actively used tool configs + notes
  [tool]/
    [config files]  #   Dotfiles (no config/ subdirectory)
    notes/          #   Tool-specific learning notes
experimental/       # Tools under evaluation (not yet active)
  [tool]/
    notes/
scripts/            # Standalone utility scripts
notes/              # Cross-cutting learning notes
```

## Key Patterns

- **Active tools**: Self-contained in `active/[tool]/`. Config files sit at the tool root (no `config/` subdirectory). Notes go in `notes/` subdirectory.
- **Experimental tools**: Not yet in daily use. Live in `experimental/[tool]/`.
- **Notes**: Use markdown with clear headings. Tool-specific notes go in the tool directory; cross-cutting notes go in top-level `notes/`.
- **Configs**: Live directly in `active/[tool]/`, symlinked to their expected system locations via Makefile.
- **Scripts**: Include a comment header explaining purpose and usage. Live in top-level `scripts/`.
- **Keybindings**: Custom keybindings should include inline comments explaining the reasoning — why this binding was chosen, what alternatives were considered, and what default it replaces. This context prevents re-investigating the same decisions later.

## Common Workflows

- Adding a new active tool: Create `active/[name]/` with config files and `notes/` subdir, add symlinks to Makefile
- Promoting experimental to active: Move from `experimental/` to `active/`, add Makefile symlinks
- Adding tool notes: Create in `active/[tool]/notes/` with descriptive filename
- Adding cross-cutting notes: Create in `notes/` for things spanning multiple tools
- Saving a config: Add to `active/[tool]/`, add symlink entry to Makefile
- Trying something new: Use `experimental/` freely

## Current Focus

- NeoVim: Setup, configuration, learning keybindings and plugins
- tmux: Session management, configuration, workflow integration
- Cursor: Settings tracking, extension management
