# tmux Future Ideas

## Reproducible Layouts

Explore scripting tmux session layouts so a single command sets up a full workspace
(e.g., editor + server + shell). Options to investigate:

- **Shell scripts**: `tmux new-session -d -s work; tmux split-window -h; tmux send-keys 'nvim' Enter; ...`
- **tmuxinator**: popular tool for declarative YAML session configs
- **tmux-resurrect / tmux-continuum**: plugins that save and restore sessions automatically

Start by identifying 1-2 layouts used repeatedly, then decide if a script or plugin fits better.

## Resolve prefix mental model (2026-03-17)

There are two ways tmux actions get triggered and it's causing split-brain:

1. **Ctrl+Space** (tmux prefix) — press, release, then action key. This is the "real" prefix.
2. **Cmd+Ctrl+key** (Ghostty keybinds) — Ghostty intercepts this and sends prefix + key to tmux automatically. Feels like a direct shortcut, not a prefix sequence.

The question: should the muscle memory be built around Ctrl+Space (portable, works in any terminal) or Cmd+Ctrl (ergonomic, but Ghostty-only)? Pick one as primary and relegate the other to fallback, or it'll stay confusing.

## Get tmux working on remote environment (2026-03-17)

Currently running tmux locally and SSHing into each window separately. This means splits/new-windows open local shells instead of remote ones. The fix is to run tmux on the remote machine (SSH once, then tmux there — all splits are automatically remote). Something is broken with tmux on the remote — debug when there's time.

Workaround in the meantime: could build a split script that detects SSH in the current pane and auto-connects the new pane to the same host.

## Known Issues

### Cmd+Shift+Arrow keys not working (2026-03-14)

Cmd+Shift+Arrow key bindings aren't functioning as expected. Not a priority right now — parking this for a future session.
