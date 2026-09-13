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


# ============================================================
# Completion
# ============================================================

autoload -Uz compinit
compinit

# Case-insensitive completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Show a menu when there are multiple completion matches.
zstyle ':completion:*' menu select


# ============================================================
# History Search
# ============================================================

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search


# ============================================================
# Autosuggestions
# ============================================================

if [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


# ============================================================
# Syntax Highlighting
# ============================================================

# Keep this near the end of .zshrc.
if [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi


# ============================================================
# Prompt
# ============================================================

autoload -Uz vcs_info

precmd() {
    vcs_info
}

zstyle ':vcs_info:git:*' formats ' %F{yellow}(%b)%f'

setopt PROMPT_SUBST

PROMPT='%F{green}%n@%m%f %F{blue}%~%f${vcs_info_msg_0_}
%F{cyan}❯%f '


# ============================================================
# Fastfetch
# ============================================================

# Show system information when opening an interactive terminal.
if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi
