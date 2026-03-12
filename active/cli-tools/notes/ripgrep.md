# ripgrep (rg) Cheat Sheet

Fast recursive search. Replacement for `grep -r`.
Respects .gitignore by default, skips binary files, blazing fast.

---

## Basic Search

```bash
# Search for a string in current directory (recursive by default)
rg "TODO"

# Search a specific file or directory
rg "error" src/
rg "config" settings.py

# Case-insensitive search
rg -i "warning"

# Exact string (no regex interpretation)
rg -F "user.name"
rg -F "$HOME"
```

## Filtering Files

```bash
# Only search certain file types
rg "import" -t py
rg "function" -t js
rg "SELECT" -t sql

# List available types
rg --type-list

# Exclude file types
rg "TODO" -T json

# Glob pattern filter
rg "class" -g "*.py"
rg "test" -g "!*.min.js"          # exclude minified
rg "config" -g "*.{yaml,yml,toml}"

# Search hidden files (normally skipped)
rg "secret" --hidden

# Search files ignored by .gitignore
rg "debug" --no-ignore
```

## Context and Output

```bash
# Show N lines before/after match
rg "error" -B 3          # 3 lines before
rg "error" -A 5          # 5 lines after
rg "error" -C 2          # 2 lines before AND after

# Show only filenames (not matching lines)
rg -l "TODO"

# Show filenames that DON'T match
rg -L "TODO"             # files without any TODO

# Count matches per file
rg -c "import"

# Show line numbers (on by default in terminal)
rg -n "function"

# Only show the matched part (not full line)
rg -o "\d{3}-\d{4}"
```

## Regex Patterns

```bash
# Find function definitions
rg "def \w+\("                    # Python
rg "function \w+\("               # JavaScript
rg "func \w+\("                   # Go

# Find IP addresses
rg "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"

# Find URLs
rg "https?://\S+"

# Find TODO/FIXME/HACK comments
rg "(TODO|FIXME|HACK|XXX)"

# Find lines starting with a pattern
rg "^import"

# Find empty lines
rg "^$"
```

## Replacement (Preview)

```bash
# Show what a replacement would look like (does not modify files)
rg "old_name" -r "new_name"

# With capture groups
rg "fn (\w+)" -r "function $1"
```

## Common Combos

```bash
# Find large files with a pattern (pipe to other tools)
rg -l "TODO" | xargs wc -l

# Search and open results in NeoVim
nvim $(rg -l "pattern")

# JSON output (for scripting)
rg "pattern" --json

# Sort results by file path
rg "pattern" --sort path

# Limit search depth
rg "pattern" --max-depth 2

# Show stats at end
rg "TODO" --stats
```

## vs grep

| grep | rg equivalent | notes |
|------|---------------|-------|
| `grep -r "foo" .` | `rg "foo"` | recursive by default |
| `grep -rn "foo" .` | `rg "foo"` | line numbers by default |
| `grep -ri "foo" .` | `rg -i "foo"` | same flag |
| `grep -rl "foo" .` | `rg -l "foo"` | same flag |
| `grep -rw "foo" .` | `rg -w "foo"` | whole word |
| `grep --include="*.py"` | `rg -t py` | cleaner syntax |
