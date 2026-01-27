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
projects/           # Self-contained tools and workflows
  [project]/
    config/         #   Dotfiles and configuration
    notes/          #   Project-specific learning notes
    scripts/        #   Project-specific utilities
    README.md       #   Project overview and setup
shared/             # Cross-project resources
  scripts/          #   Utilities useful across projects
  references/       #   Cheatsheets, links, external resources
  notes/            #   General learning notes
experiments/        # Throwaway explorations and trials
```

## Key Patterns

- **Projects**: Self-contained in `projects/[name]/`. Each project has its own config, notes, and scripts.
- **Notes**: Use markdown with clear headings. Date prefix optional.
- **Configs**: Live in `projects/[tool]/config/`, mirror the actual dotfile structure
- **Scripts**: Include a comment header explaining purpose and usage. Project-specific scripts go in the project; general utilities go in `shared/scripts/`.

## Common Workflows

- Adding a new project: Create `projects/[name]/` with `config/`, `notes/`, `scripts/` subdirs and a README
- Adding project notes: Create in `projects/[project]/notes/` with descriptive filename
- Adding shared notes: Create in `shared/notes/` for cross-project learning
- Saving a config: Add to `projects/[tool]/config/`, document dependencies in the project README
- Trying something new: Use `experiments/` freely - it's meant for mess
- Finding info: Check project notes first, then `shared/`

## Current Focus

- NeoVim: Setup, configuration, learning keybindings and plugins
- tmux: Session management, configuration, workflow integration
