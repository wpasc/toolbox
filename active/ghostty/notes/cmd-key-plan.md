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

## Cmd Mappings

| Shortcut | Action | tmux equivalent | Notes |
|----------|--------|----------------|-------|
| Cmd+T | New tab (tmux window) | prefix + n | Matches browser/Cursor Cmd+T. Cmd+N left for Ghostty's native new window. |
| Cmd+W | Close tab | prefix + w | No confirmation — matches browser instant-close. |
| Cmd+1 through Cmd+9 | Switch to tab N | prefix + 1-9 | Overrides both super+N and super+digit_N Ghostty defaults. |
| Cmd+\\ | Vertical split (left/right) | prefix + \| | Also bound in Cursor for consistency. |
| Cmd+- | Horizontal split (top/bottom) | prefix + - | Also bound in Cursor. Overrides Ghostty's decrease_font_size. |
| Cmd+Opt+Left | Previous window | prefix + H | Uppercase H = window-level (vs lowercase h = pane) |
| Cmd+Opt+Right | Next window | prefix + L | Uppercase L = window-level (vs lowercase l = pane) |
| Cmd+Ctrl+Left | Move to left pane | prefix + h | |
| Cmd+Ctrl+Right | Move to right pane | prefix + l | |
| Cmd+Ctrl+Up | Move to pane above | prefix + k | |
| Cmd+Ctrl+Down | Move to pane below | prefix + j | |
| Cmd+Ctrl+B | Swap window left | prefix + B | B = back. Reorders the tab position. |
| Cmd+Ctrl+N | Swap window right | prefix + N | N = next. Reorders the tab position. |

## Modifier Scheme

| Modifier | Controls | Examples |
|----------|----------|----------|
| Cmd | tmux actions (create, close, split, jump) | Cmd+T, Cmd+W, Cmd+1-9 |
| Cmd+Shift | Ghostty-native actions | Cmd+Shift+T (Ghostty tab) |
| Cmd+Opt | Window navigation | Cmd+Opt+Left/Right |
| Cmd+Ctrl | Pane navigation + window reordering | Cmd+Ctrl+Arrows, Cmd+Ctrl+B/N |

## Cross-Tool Consistency

| Action | Ghostty/tmux | Cursor |
|--------|-------------|--------|
| New tab | Cmd+T | Cmd+T (default) |
| Close tab | Cmd+W | Cmd+W (default) |
| Split vertical | Cmd+\\ | Cmd+\\ (custom) |
| Split horizontal | Cmd+- | Cmd+- (custom) |

## Spotlight / Cmd+Space: No Change Needed

The Cmd mappings above are direct — Ghostty intercepts them and sends the tmux
action immediately. No prefix is involved. Cmd+Space (Spotlight) is never used,
so there's no conflict.

Ctrl+Space remains the tmux prefix for less common actions that don't have a Cmd
shortcut (rename window, copy mode, session management, etc.).

## Status

Implemented and tested. Ghostty config uses `super` (not `cmd`) and `alt` (not `opt`)
for key names. Number keys require overriding both `super+N` and `super+digit_N`.
