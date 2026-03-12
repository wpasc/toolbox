# bat Cheat Sheet

A `cat` replacement with syntax highlighting, line numbers, and git integration.

---

## Basic Usage

```bash
# View a file (syntax highlighting + line numbers)
bat file.py
bat README.md

# Multiple files (shows headers between them)
bat src/*.py

# Read from stdin (auto-detect or specify language)
echo '{"key": "value"}' | bat -l json
curl -s https://example.com/api | bat -l json
```

## Display Options

```bash
# Plain output (no line numbers, no header, no grid)
bat -p file.py

# Just syntax highlighting, no decorations
bat -pp file.py

# Choose what to show
bat --style=numbers file.py         # line numbers only
bat --style=header,grid file.py     # header + grid only
bat --style=full file.py            # everything (default)

# Available style components: header, grid, numbers, snip, changes

# Show non-printable characters (tabs, spaces, newlines)
bat -A file.py

# Specific line range
bat -r 10:20 file.py      # lines 10-20
bat -r :50 file.py        # first 50 lines
bat -r 100: file.py       # line 100 to end

# Highlight specific lines
bat -H 5 -H 10:15 file.py
```

## Syntax and Themes

```bash
# Force a language (when auto-detect fails)
bat -l python script
bat -l yaml data.txt
bat -l markdown notes

# List available languages
bat --list-languages

# List available themes
bat --list-themes

# Use a specific theme
bat --theme="Dracula" file.py

# Preview all themes on a file
bat --list-themes | fzf --preview="bat --theme={} --color=always file.py"
```

## Git Integration

```bash
# Show git changes in the gutter (added/modified/deleted lines)
# This is ON by default if the file is in a git repo
bat file.py               # ~ modified, + added, - deleted in gutter
```

## Common Combos

```bash
# Use as a pager for other commands
help git | bat -l help
man ls | bat -l man

# Diff two files with syntax highlighting (use with diff)
diff file1.py file2.py | bat -l diff

# Preview files with fzf
fzf --preview "bat --color=always {}"

# Cat multiple files into one with highlighting
bat header.py main.py footer.py

# Show file with line numbers for code review
bat -n file.py

# Quick view of a function (if you know the line range)
bat -r 45:60 src/utils.py
```

## As a cat Replacement

```bash
# Add to .zshrc / .bashrc to use bat as default cat
alias cat="bat"

# Or keep both available
alias cat="bat --paging=never"    # bat without pager
alias less="bat --paging=always"  # bat as pager

# bat respects BAT_THEME env var
export BAT_THEME="Visual Studio Dark+"

# bat respects BAT_STYLE env var
export BAT_STYLE="numbers,changes"
```

## Configuration File

```bash
# Create a config file for persistent settings
mkdir -p ~/.config/bat
cat > ~/.config/bat/config << 'EOF'
--theme="Visual Studio Dark+"
--style="numbers,changes,header"
--italic-text=always
EOF

# Config file location
bat --config-file
```

## vs cat

| cat | bat equivalent | notes |
|-----|----------------|-------|
| `cat file` | `bat file` | + highlighting, line numbers |
| `cat -n file` | `bat file` | line numbers by default |
| `cat -A file` | `bat -A file` | show non-printable |
| `cat f1 f2 > out` | `bat -pp f1 f2 > out` | plain mode for piping |

**Note:** bat auto-detects when output is piped and switches to plain mode,
so `bat file.py | head` works like `cat file.py | head`.
