# fd Cheat Sheet

Fast, user-friendly replacement for `find`.
Respects .gitignore, colorized output, smart case, regex by default.

---

## Basic Search

```bash
# Find files by name (substring match, recursive)
fd readme
fd test

# Search in a specific directory
fd config src/
fd "\.py$" ~/projects/

# Exact filename
fd -g "Makefile"          # glob mode (not regex)
fd "^Makefile$"           # regex mode (default)
```

## Filtering

```bash
# By extension
fd -e py                  # all .py files
fd -e md -e txt           # multiple extensions
fd -e json config         # .json files containing "config"

# By type
fd -t f                   # files only
fd -t d                   # directories only
fd -t l                   # symlinks only
fd -t x                   # executables only

# Include hidden files (normally skipped)
fd -H ".env"

# Include gitignored files
fd -I "node_modules"

# Both hidden AND gitignored
fd -HI "cache"

# Max depth
fd -d 2 "test"            # only 2 levels deep

# Exclude directories
fd -E node_modules -E .git "config"
fd -E "*.min.js" "\.js$"
```

## Output and Actions

```bash
# Full path (absolute)
fd -a "\.py$"

# Print with null separator (safe for xargs)
fd -0 "\.log$" | xargs -0 rm

# Execute a command on each result
fd -e py -x wc -l         # line count for each .py file
fd -e jpg -x convert {} {.}.png   # convert jpg to png

# Execute a command with all results at once
fd -e py -X wc -l         # total line count (one wc call)

# Colored output (default in terminal)
fd --color always "test" | less -R
```

## Common Patterns

```bash
# Find all Python files
fd -e py

# Find all config files
fd -g "*.{yaml,yml,toml,json,ini,cfg}"

# Find large files (combine with other tools)
fd -t f -e log -x ls -lh {}

# Find recently modified files
fd -t f --changed-within 1d
fd -t f --changed-within 2h

# Find old files
fd -t f --changed-before "2024-01-01"

# Find empty files
fd -t f --size 0

# Find files by size
fd -t f --size +1m         # larger than 1 MB
fd -t f --size -10k        # smaller than 10 KB

# Delete all .pyc files
fd -e pyc -x rm {}
# Or safer with confirmation:
fd -e pyc

# Find and open in editor
nvim $(fd -e py "test")
```

## vs find

| find | fd equivalent | notes |
|------|---------------|-------|
| `find . -name "*.py"` | `fd -e py` | way shorter |
| `find . -type f -name "*.js"` | `fd -t f -e js` | cleaner |
| `find . -type d -name test` | `fd -t d test` | same idea |
| `find . -name "*.log" -delete` | `fd -e log -x rm {}` | safer pattern |
| `find . -maxdepth 2 -name "*.md"` | `fd -d 2 -e md` | same concept |
| `find . -newer file.txt` | `fd --changed-after file.txt` | more intuitive |
| `find . -iname "readme"` | `fd -i readme` | case insensitive |

## Useful Aliases

```bash
# Add to .zshrc / .bashrc
alias f="fd"
alias ff="fd -t f"        # files only
alias fdir="fd -t d"      # directories only
```
