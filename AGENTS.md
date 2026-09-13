# AGENTS.md

## Repository purpose

This repository manages a reproducible Fedora Linux development environment.

Configuration files stored here are intended to become the source of truth for the user's workstation.

Agents modifying this repository should treat it like infrastructure code: changes should be explicit, portable, reversible, and tested.

## General rules

Use portable paths.

Prefer:

```bash
$HOME
${XDG_CONFIG_HOME:-$HOME/.config}
${XDG_STATE_HOME:-$HOME/.local/state}
```

Do not hardcode the user's home directory or username.

Keep configuration readable. Avoid unnecessary frameworks, plugins, dependencies, or abstractions when native functionality is sufficient.

Preserve existing working behavior unless the task explicitly requires changing it.

## Security

Never commit secrets or credentials.

Do not add:

```text
API keys
authentication tokens
passwords
private keys
.env files
credential files
machine-local authentication data
```

Assume the repository is publicly visible.

Do not weaken `.gitignore` protections for sensitive files without a clear reason.

## Shell configuration

Zsh is the primary shell.

Keep `.zshenv` minimal and suitable for non-interactive shells.

Place interactive functionality in `.zshrc`.

Do not run expensive initialization during every shell startup when lazy initialization is practical.

Conda currently uses lazy initialization and should remain that way unless a change is explicitly justified.

## System Python

Do not install user development packages into Fedora's system Python.

Use isolated environments such as Conda environments or project-specific virtual environments.

## Deployment

`scripts/link-configs.sh` manages configuration symlinks.

The script should:

* be safe to run multiple times
* preserve correct existing links
* back up conflicting configuration
* never silently destroy user files
* fail clearly when required source configuration is missing

## Validation

Run appropriate checks before considering a change complete.

For Zsh:

```bash
zsh -n zsh/.zshrc
zsh -n zsh/.zshenv
```

For Bash scripts:

```bash
bash -n scripts/link-configs.sh
```

For Fastfetch:

```bash
fastfetch --config fastfetch/config.jsonc
```

For Git changes:

```bash
git diff
git diff --cached
git status
```

## Git discipline

Keep commits focused.

Use descriptive messages with an area prefix where useful:

```text
zsh:
scripts:
fastfetch:
ghostty:
nvim:
docs:
```

Avoid mixing unrelated workstation changes into one commit.

Do not rewrite shared Git history unless explicitly requested.

## Future configuration

The repository is expected to expand to include:

```text
Ghostty
Neovim / LazyVim
Python development tooling
R development tooling
SQL tooling
Quarto
Jupyter / Jupytext
Claude Code integration
```

Add these incrementally rather than introducing the entire stack in one untested change.
