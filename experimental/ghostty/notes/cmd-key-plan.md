# Cmd Key Integration Plan

## Goal

Make Cmd+key the primary interface for tmux, matching browser/Cursor muscle memory.
This eliminates the two-step prefix sequence for common actions.

## Layer Model

| Layer | Modifier | Controls |
|-------|----------|----------|
| Ghostty (terminal) | **Cmd** + key | tmux commands |
| NeoVim | **Space** + key | Editor commands |
| tmux fallback | **Ctrl+Space** + key | Less common tmux actions |

No conflicts between layers — Cmd is intercepted by the terminal before tmux/NeoVim see it.

## Planned Cmd Mappings

| Shortcut | Action | tmux equivalent |
|----------|--------|----------------|
| Cmd+N | New window | prefix + n |
| Cmd+W | Close window | prefix + w |
| Cmd+1 through Cmd+9 | Switch to window N | prefix + 1-9 |
| Cmd+D | Vertical split (left/right) | prefix + \| |
| Cmd+Shift+D | Horizontal split (top/bottom) | prefix + - |
| Cmd+Opt+Left | Move to left pane | prefix + h |
| Cmd+Opt+Right | Move to right pane | prefix + l |
| Cmd+Opt+Up | Move to pane above | prefix + k |
| Cmd+Opt+Down | Move to pane below | prefix + j |

## Spotlight / Cmd+Space: No Change Needed

The Cmd mappings above are direct — Ghostty intercepts Cmd+N, Cmd+W, etc. and sends
the tmux action immediately. No prefix is involved. Cmd+Space (Spotlight) is never
used, so there's no conflict and no need to remap it.

Ctrl+Space remains the tmux prefix for less common actions that don't have a Cmd
shortcut (rename window, copy mode, session management, etc.).

## Status

Waiting on Ghostty installation and testing. The exact keybind syntax needs to be
verified against a running tmux session.
