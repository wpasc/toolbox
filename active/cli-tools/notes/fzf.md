# fzf Cheat Sheet

Fuzzy finder for the terminal. Turns any list into an interactive, filterable menu.
Extremely powerful when combined with other tools.

---

## Shell Integration (setup)

```bash
# After brew install, enable shell keybindings and completion
# Add to .zshrc:
source <(fzf --zsh)

# Or for bash, add to .bashrc:
eval "$(fzf --bash)"

# This gives you three keybindings:
#   Ctrl+R   fuzzy search command history
#   Ctrl+T   fuzzy find files, insert path at cursor
#   Alt+C    fuzzy find directories, cd into selection
```

## Basic Usage

```bash
# Pipe any list into fzf for interactive selection
ls | fzf
fd | fzf
rg -l "TODO" | fzf

# fzf prints the selected item to stdout
# Use $() to capture it
nvim $(fzf)                     # find and open a file
cd $(fd -t d | fzf)             # find and cd into a directory
```

## Search Syntax

```
sbtrkt     fuzzy match "sbtrkt"
'exact     exact match (prefix with ')
^prefix    starts with "prefix"
suffix$    ends with "suffix"
!negation  does NOT contain "negation"
!^prefix   does NOT start with "prefix"

# Combine terms with spaces (AND logic)
^src .py$                  # starts with src AND ends with .py
model !test                # contains model, NOT test
```

## Keyboard Controls (inside fzf)

```
Enter        select current item
Tab          mark item (multi-select mode)
Shift+Tab    unmark item
Ctrl+A       select all (multi-select)
Ctrl+D       deselect all
Up/Down      navigate
Ctrl+J/K     navigate (vim-style)
Ctrl+C       cancel
?            toggle preview window (if configured)
```

## Preview Window

```bash
# File preview with bat
fzf --preview "bat --color=always {}"

# Preview with line numbers starting from match
rg -l "error" | fzf --preview "rg --color=always -C 3 'error' {}"

# Custom preview size and position
fzf --preview "bat --color=always {}" --preview-window=right:60%

# Preview below
fzf --preview "bat --color=always {}" --preview-window=down:50%

# Toggle preview with ?
fzf --preview "bat {}" --bind "?:toggle-preview"
```

## Common Workflows

### Find and Open Files

```bash
# Find any file and open in nvim
nvim $(fzf)

# Find files with preview
nvim $(fzf --preview "bat --color=always {}")

# Find only Python files
nvim $(fd -e py | fzf --preview "bat --color=always {}")
```

### Search File Contents

```bash
# Grep for pattern, then fuzzy-filter results, open selection
rg "pattern" -l | fzf --preview "rg --color=always -C 3 'pattern' {}" | xargs nvim

# Interactive ripgrep (re-search as you type)
# This is powerful -- fzf re-runs rg on each keystroke
fzf --bind "change:reload:rg --color=always {q} || true" \
    --ansi --disabled \
    --preview "rg --color=always -C 3 {q} {}"
```

### Git Integration

```bash
# Fuzzy checkout branch
git branch | fzf | xargs git checkout

# Browse commits
git log --oneline | fzf --preview "git show {1}"

# Stage files interactively
git status -s | fzf -m | awk '{print $2}' | xargs git add

# Fuzzy stash selection
git stash list | fzf | cut -d: -f1 | xargs git stash pop
```

### Process Management

```bash
# Find and kill a process
kill $(ps aux | fzf | awk '{print $2}')

# Or with signal selection
ps aux | fzf | awk '{print $2}' | xargs kill -9
```

### Directory Navigation

```bash
# cd into a subdirectory
cd $(fd -t d | fzf)

# cd into a project directory
cd $(fd -t d -d 1 . ~/projects | fzf)
```

## Multi-Select Mode

```bash
# Enable multi-select with -m
fd -e py | fzf -m                  # Tab to mark, Enter to confirm
fd -e py | fzf -m | xargs nvim    # open multiple files

# Select multiple files to delete
fd -e log | fzf -m | xargs rm
```

## Environment Variables

```bash
# Default options (add to .zshrc)
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# Use fd as default file finder (faster than find, respects .gitignore)
export FZF_DEFAULT_COMMAND="fd --type f"

# Ctrl+T uses fd
export FZF_CTRL_T_COMMAND="fd --type f"

# Alt+C uses fd for directories
export FZF_ALT_C_COMMAND="fd --type d"

# Preview for Ctrl+T
export FZF_CTRL_T_OPTS="--preview 'bat --color=always {}'"
```

## Useful Aliases

```bash
# Add to .zshrc / .bashrc

# Interactive file opener
alias fv='nvim $(fzf --preview "bat --color=always {}")'

# Interactive cd
alias fcd='cd $(fd -t d | fzf)'

# Interactive git checkout
alias fco='git branch | fzf | xargs git checkout'

# Interactive process kill
alias fkill='kill $(ps aux | fzf | awk "{print \$2}")'
```
