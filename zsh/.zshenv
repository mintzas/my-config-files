# Keep PATH configuration here.
# .zshenv is loaded by interactive and non-interactive Zsh sessions.

typeset -U path PATH

path=(
    $HOME/.local/bin
    $HOME/bin
    $HOME/.cargo/bin
    /usr/local/bin
    /usr/bin
    /bin
    $path
)

export PATH
