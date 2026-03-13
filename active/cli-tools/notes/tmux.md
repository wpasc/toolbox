# tmux Cheat Sheet

Terminal multiplexer: multiple windows and panes in a single terminal.
Your prefix key is **Ctrl+Space** (press it, release, then press the next key).

---

## The Basics

```
Ctrl+Space  then ...       What it does
──────────────────────────────────────────────────
```

Everything in tmux starts with the **prefix** (Ctrl+Space). You press it,
let go, then press the action key. This is written as `prefix + X` below.

## Sessions

```
tmux                       start a new session
tmux new -s work           start a new named session
tmux ls                    list sessions
tmux attach -t work        attach to a session by name
tmux kill-session -t work  kill a session

prefix + d                 detach from current session
prefix + s                 list/switch sessions (interactive)
prefix + $                 rename current session
```

Sessions persist in the background after detaching. This is tmux's killer
feature — you can close your terminal and come back later.

## Windows (tabs in the status bar)

```
prefix + n                 new window              [custom, like Cmd+N]
prefix + w                 close window (confirms)  [custom, like Cmd+W]
prefix + ,                 rename current window
prefix + 1-9               jump to window by number
prefix + p                 previous window
prefix + F                 find windows/sessions    [plugin, replaces default w]
```

Windows show as tabs in the top bar. The active one is highlighted.

## Panes (splits within a window)

### Creating Panes

```
prefix + |                 split vertically   (left/right)  [custom]
prefix + -                 split horizontally (top/bottom)  [custom]
```

### Navigating Panes

```
prefix + h                 move left           [custom, vim-style]
prefix + j                 move down           [custom, vim-style]
prefix + k                 move up             [custom, vim-style]
prefix + l                 move right          [custom, vim-style]
prefix + arrow keys        move in direction   [default, also works]
prefix + o                 cycle to next pane
prefix + ;                 toggle to last pane
```

### Resizing Panes

```
prefix + z                 toggle pane zoom (fullscreen and back)
prefix + Ctrl+arrow        resize pane in that direction
prefix + Space             cycle through pane layouts
```

### Closing Panes

```
exit  (or Ctrl+D)          close current pane
prefix + x                 close current pane (confirms)
```

## Copy Mode (scrollback and selection)

```
prefix + [                 enter copy mode (scroll/select)
q                          exit copy mode

In copy mode:
  Up/Down or k/j           scroll line by line
  Ctrl+U / Ctrl+D          scroll half page up/down
  g / G                    jump to top / bottom
  /pattern                 search forward
  ?pattern                 search backward
  n / N                    next / previous search match
  Space                    start selection
  Enter                    copy selection (goes to clipboard via OSC 52)
```

Mouse scrolling also enters copy mode automatically (mouse is enabled).

## Plugins (TPM)

```
prefix + I                 install new plugins (after adding to tmux.conf)
prefix + U                 update plugins
prefix + Alt+u             remove plugins no longer in tmux.conf
```

### tmux-fzf

```
prefix + F                 open tmux-fzf (fuzzy find sessions/windows/panes)
```

## Config Management

```
prefix + r                 reload tmux.conf    [custom]
```

## Quick Reference: Custom vs Default

```
Custom bindings (from your tmux.conf):
  Ctrl+Space               prefix (instead of Ctrl+B)
  prefix + n               new window (instead of c)
  prefix + w               close window (instead of &)
  prefix + |               vertical split (instead of %)
  prefix + -               horizontal split (instead of ")
  prefix + h/j/k/l         vim-style pane navigation
  prefix + r               reload config
  prefix + F               tmux-fzf (plugin, replaces default w picker)

Everything else is tmux defaults.
```

## Common Workflows

### Start a new project workspace

```bash
tmux new -s myproject
# You're now in window 1
# prefix + n  to create more windows (e.g., editor, server, logs)
# prefix + ,  to rename each window
```

### Split screen: editor + terminal

```
prefix + |                 split vertically
# Left pane: nvim
# Right pane: run commands
prefix + h / prefix + l    switch between them
prefix + z                 zoom a pane to fullscreen, again to restore
```

### Detach and come back later

```
prefix + d                 detach (everything keeps running)
# Close terminal, go get coffee, come back:
tmux attach                reattach to your session
```
