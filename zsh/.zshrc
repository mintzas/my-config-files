# ============================================================
# Michalis - Zsh Configuration
# ============================================================

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# Useful aliases
alias ll='ls -lah'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Use Neovim when we install it later
if command -v nvim >/dev/null 2>&1; then
    alias vim='nvim'
    alias vi='nvim'
fi


# ============================================================
# Conda
# ============================================================

# Miniconda installation location.
CONDA_ROOT="$HOME/miniconda3"

# Lazy-load Conda the first time it is used.
# This avoids initializing Conda every time Zsh starts.
if [[ -x "$CONDA_ROOT/bin/conda" ]]; then
    conda() {
        unset -f conda
        eval "$("$CONDA_ROOT/bin/conda" shell.zsh hook)"
        conda "$@"
    }
fi
