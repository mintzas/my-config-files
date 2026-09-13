#!/usr/bin/env bash

set -Eeuo pipefail

# ============================================================
# Fedora workstation bootstrap
# ============================================================

# Refuse to run on non-Fedora systems.
if [[ ! -f /etc/fedora-release ]]; then
    echo "Error: this installer is intended for Fedora Linux." >&2
    exit 1
fi

echo "Installing core workstation packages..."

packages=(
    git
    gh
    zsh
    fastfetch
    kitty
    zsh-autosuggestions
    zsh-syntax-highlighting
    ripgrep
    fd-find
    fzf
    bat
    curl
    wget
    tree
)

sudo dnf install -y "${packages[@]}"

echo
echo "Core packages installed."

# ------------------------------------------------------------
# Information
# ------------------------------------------------------------

echo
echo "Installed tools:"
printf '  Git:       %s\n' "$(git --version)"
printf '  Zsh:       %s\n' "$(zsh --version)"
printf '  Fastfetch: %s\n' "$(fastfetch --version | head -n1)"
printf '  GitHub CLI:%s\n' " $(gh --version | head -n1)"
printf '  Kitty:     %s\n' "$(kitty --version)"

echo
echo "Notes:"

if [[ -x "$HOME/miniconda3/bin/conda" ]]; then
    echo "  - Miniconda detected at $HOME/miniconda3."
else
    echo "  - Miniconda is not installed. It is managed separately."
fi

if ! command -v ghostty >/dev/null 2>&1; then
    echo "  - Ghostty is not installed. It is an optional terminal."
else
    echo "  - Ghostty detected."
fi

echo
echo "Package installation complete."
echo "Next run:"
echo
echo "  ./scripts/link-configs.sh"
