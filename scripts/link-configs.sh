#!/usr/bin/env bash

set -Eeuo pipefail

# Find the root of this repository regardless of where the script is run from.
repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"

# If an existing config has to be replaced, store it here first.
backup_dir="${XDG_STATE_HOME:-$HOME/.local/state}/my-config-files/backups/$(date +%Y%m%d-%H%M%S)"

backed_up=false

link_config() {
    local source="$1"
    local target="$2"
    local current=""
    local backup_target=""

    # Refuse to continue if the source file from our repo does not exist.
    if [[ ! -e "$source" ]]; then
        printf 'Error: source does not exist: %s\n' "$source" >&2
        exit 1
    fi

    # Make sure the target's parent directory exists.
    mkdir -p -- "$(dirname -- "$target")"

    # If the correct symlink already exists, do nothing.
    if [[ -L "$target" ]]; then
        current="$(readlink -f -- "$target" 2>/dev/null || true)"

        if [[ "$current" == "$source" ]]; then
            printf 'Already linked: %s\n' "$target"
            return
        fi
    fi

    # If something already exists at the target location, back it up.
    if [[ -e "$target" || -L "$target" ]]; then
        backup_target="$backup_dir/${target#$HOME/}"

        mkdir -p -- "$(dirname -- "$backup_target")"
        mv -- "$target" "$backup_target"

        backed_up=true

        printf 'Backed up: %s -> %s\n' "$target" "$backup_target"
    fi

    # Create the symbolic link.
    ln -s -- "$source" "$target"

    printf 'Linked: %s -> %s\n' "$target" "$source"
}

# ------------------------------------------------------------
# Zsh
# ------------------------------------------------------------

link_config "$repo_dir/zsh/.zshenv" "$HOME/.zshenv"
link_config "$repo_dir/zsh/.zshrc" "$HOME/.zshrc"

if [[ "$backed_up" == true ]]; then
    printf '\nExisting configuration was backed up under:\n%s\n' "$backup_dir"
fi

printf '\nConfiguration linking complete.\n'


# ------------------------------------------------------------
# Fastfetch
# ------------------------------------------------------------

link_config \
    "$repo_dir/fastfetch/config.jsonc" \
    "$HOME/.config/fastfetch/config.jsonc"

# ------------------------------------------------------------
# Kitty
# ------------------------------------------------------------

link_config \
    "$repo_dir/kitty/kitty.conf" \
    "$HOME/.config/kitty/kitty.conf"


# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------

if [[ "$backed_up" == true ]]; then
    printf '\nExisting configuration was backed up under:\n%s\n' "$backup_dir"
fi

printf '\nConfiguration linking complete.\n'
