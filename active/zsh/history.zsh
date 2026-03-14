# ─── Standard zsh history ────────────────────────────────────────────────────
# Shared across all sessions, supports Ctrl+R recall

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY       # Timestamps in history file
setopt INC_APPEND_HISTORY     # Write immediately, not on shell exit
setopt SHARE_HISTORY          # Share history across all sessions
setopt HIST_IGNORE_DUPS       # Skip consecutive duplicates
setopt HIST_IGNORE_SPACE      # Commands starting with space aren't recorded
setopt HIST_REDUCE_BLANKS     # Remove extra whitespace
setopt HIST_VERIFY            # Show expanded history before executing

# ─── Daily history log ───────────────────────────────────────────────────────
# Appends each command to a daily log file with timestamp and tmux context.
# Logs live in the toolbox (usage-logs/shell/) but are gitignored.
# Format: YYYY-MM-DD HH:MM:SS [session:window.pane] command
#
# These daily logs are designed to be fed to an LLM for pattern analysis —
# identifying power-user opportunities and repeated mistakes.

TOOLBOX_HISTORY_DIR="$HOME/workspace/toolbox/usage-logs/shell"
mkdir -p "$TOOLBOX_HISTORY_DIR"

_daily_history_log() {
    local cmd="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_file="$TOOLBOX_HISTORY_DIR/$(date '+%Y-%m-%d').log"

    # Capture tmux context if available
    local context="-"
    if [ -n "$TMUX" ]; then
        local session=$(tmux display-message -p '#S' 2>/dev/null)
        local window=$(tmux display-message -p '#I' 2>/dev/null)
        local pane=$(tmux display-message -p '#P' 2>/dev/null)
        context="${session}:${window}.${pane}"
    fi

    echo "${timestamp} [${context}] ${cmd}" >> "$log_file"
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _daily_history_log
