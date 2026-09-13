#!/usr/bin/env bash

set -Eeuo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
extensions_file="$repo_dir/vscode/extensions.txt"

if ! command -v code >/dev/null 2>&1; then
    echo "Error: VS Code command 'code' was not found." >&2
    exit 1
fi

if [[ ! -f "$extensions_file" ]]; then
    echo "Error: extension list not found: $extensions_file" >&2
    exit 1
fi

echo "Installing VS Code extensions..."

while IFS= read -r extension; do
    [[ -z "$extension" ]] && continue

    echo "Installing: $extension"
    code --install-extension "$extension"
done < "$extensions_file"

echo
echo "VS Code extensions installed."
