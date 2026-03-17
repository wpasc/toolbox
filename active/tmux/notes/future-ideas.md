# tmux Future Ideas

## Reproducible Layouts

Explore scripting tmux session layouts so a single command sets up a full workspace
(e.g., editor + server + shell). Options to investigate:

- **Shell scripts**: `tmux new-session -d -s work; tmux split-window -h; tmux send-keys 'nvim' Enter; ...`
- **tmuxinator**: popular tool for declarative YAML session configs
- **tmux-resurrect / tmux-continuum**: plugins that save and restore sessions automatically

Start by identifying 1-2 layouts used repeatedly, then decide if a script or plugin fits better.

## Known Issues

### Cmd+Shift+Arrow keys not working (2026-03-14)

Cmd+Shift+Arrow key bindings aren't functioning as expected. Not a priority right now — parking this for a future session.
