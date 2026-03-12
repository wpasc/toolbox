# delta Cheat Sheet

A viewer for git diffs with syntax highlighting and side-by-side mode.
Works as a drop-in git pager -- once configured, all git diff output uses delta.

---

## Setup (one-time)

```bash
# Configure git to use delta as its pager
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.dark true
git config --global delta.side-by-side true
git config --global delta.line-numbers true

# Or add this to ~/.gitconfig manually:
# [core]
#     pager = delta
# [interactive]
#     diffFilter = delta --color-only
# [delta]
#     navigate = true
#     dark = true
#     side-by-side = true
#     line-numbers = true
```

After setup, delta is automatic -- every `git diff`, `git log -p`, `git show`,
etc. will render through delta with no extra flags.

## Git Commands (now enhanced by delta)

```bash
# All of these now render through delta automatically
git diff                   # working tree vs staged
git diff --staged          # staged vs last commit
git diff HEAD~3            # last 3 commits
git diff main..feature     # branch comparison
git show HEAD              # last commit details
git log -p                 # commits with diffs
git log -p -5              # last 5 commits with diffs
git stash show -p          # stash contents
git blame file.py          # blame with syntax highlighting
```

## Navigation (when viewing diffs)

```
n    jump to next file in diff
N    jump to previous file in diff
q    quit
/    search
```

These work because `delta.navigate = true` sets up special markers
that the pager (less) can jump between.

## Standalone Usage (without git)

```bash
# Diff two files directly
delta file_old.py file_new.py

# Pipe any diff through delta
diff -u old.py new.py | delta

# View a patch file
cat changes.patch | delta
```

## Display Options

```bash
# Side-by-side mode (can also set in gitconfig)
git diff | delta --side-by-side
git diff | delta -s                    # short flag

# Disable side-by-side for narrow terminals
git diff | delta --side-by-side=false

# Line numbers
git diff | delta --line-numbers

# Word-level diff highlighting (on by default)
# delta highlights exactly which words changed within a line

# Show file paths as hyperlinks (clickable in supporting terminals)
git diff | delta --hyperlinks
```

## Themes and Appearance

```bash
# List available syntax themes
delta --list-syntax-themes

# Preview a theme
delta --syntax-theme="Dracula" < <(git diff)

# Set in gitconfig
git config --global delta.syntax-theme "Visual Studio Dark+"

# Useful gitconfig delta options:
# [delta]
#     syntax-theme = "Visual Studio Dark+"
#     side-by-side = true
#     line-numbers = true
#     navigate = true
#     dark = true
#     file-style = bold yellow
#     hunk-header-style = line-number syntax
```

## Full Recommended gitconfig

```ini
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    dark = true
    side-by-side = true
    line-numbers = true
    syntax-theme = "Visual Studio Dark+"
    file-style = bold yellow ul
    file-decoration-style = none
    hunk-header-decoration-style = blue box
    hunk-header-style = file line-number syntax

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
```

## Troubleshooting

```bash
# Check if delta is being used
git config --get core.pager    # should say "delta"

# Temporarily bypass delta
git --no-pager diff            # raw diff, no pager at all
GIT_PAGER=cat git diff         # plain output

# If colors look wrong, check terminal
# delta needs a terminal with 24-bit color support (truecolor)
# iTerm2, Alacritty, kitty all support this
```
