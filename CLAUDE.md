# CLAUDE.md

## Purpose

This repository contains the user's personal Fedora Linux workstation configuration.

Treat the repository as infrastructure/configuration code. Changes can affect the user's login shell and development environment, so prefer small, reversible, tested changes.

## Platform

Primary platform:

```text
Fedora Linux
Zsh
GNOME / Wayland
```

The repository must remain username-independent.

Use:

```bash
$HOME
```

and standard XDG locations rather than hardcoding paths such as:

```text
/home/maikeru
```

## Repository architecture

Current configuration areas:

```text
zsh/          Zsh configuration
fastfetch/    Fastfetch configuration
scripts/      deployment and setup scripts
ghostty/      terminal configuration
nvim/         Neovim configuration
```

`ghostty/` and `nvim/` may initially be incomplete while the environment is being built.

## Deployment model

Files inside this repository are the source of truth.

Configuration should normally be deployed using symbolic links rather than copied into the user's home directory.

The deployment script is:

```bash
scripts/link-configs.sh
```

It must remain safe to rerun and should back up conflicting user configuration before replacing it.

Do not silently overwrite existing configuration.

## Zsh

The repository manages:

```text
zsh/.zshenv
zsh/.zshrc
```

Keep `.zshenv` small.

It should contain environment configuration required by interactive and non-interactive Zsh sessions, particularly PATH configuration.

Interactive behavior belongs in `.zshrc`.

Examples include:

* aliases
* completion
* history
* prompt configuration
* shell plugins
* Fastfetch
* Conda integration

## Conda

Miniconda currently lives at:

```text
$HOME/miniconda3
```

Conda is intentionally lazy-loaded from `.zshrc`.

Do not replace the lazy-loading implementation with a standard `conda init` block unless there is a clear reason.

Do not install Python packages into Fedora's system Python.

Use Conda environments or project-local virtual environments for Python development.

## Secrets

Never add secrets to this repository.

Do not commit:

```text
API keys
tokens
passwords
SSH private keys
.env files
credential stores
Claude authentication information
```

Never place secrets directly inside `.zshrc`, `.zshenv`, Git configuration, or tracked scripts.

Use environment variables or a secure credential store instead.

## Safety

Do not run destructive commands unless explicitly requested.

Avoid:

```text
rm -rf on user directories
force pushes
destructive Git resets
uninstalling system packages
overwriting configuration without backups
```

Do not run privileged commands with `sudo` unless the user explicitly approves the operation.

## Validation

Before proposing or committing shell configuration changes, validate them when applicable.

Zsh configuration:

```bash
zsh -n zsh/.zshrc
zsh -n zsh/.zshenv
```

Bash scripts:

```bash
bash -n scripts/link-configs.sh
```

Fastfetch:

```bash
fastfetch --config fastfetch/config.jsonc
```

After modifying symbolic-link deployment, verify the resulting targets with `readlink -f`.

## Git

Keep commits focused and descriptive.

Preferred commit style:

```text
zsh: add history search
scripts: improve backup handling
fastfetch: customize displayed modules
nvim: add Python tooling
docs: document workstation setup
```

Do not commit generated caches, temporary files, secrets, or machine-local authentication data.

## Philosophy

Prefer simple configuration that is understood and maintained by the user over large frameworks added solely for convenience.

Avoid adding unnecessary dependencies.

When borrowing ideas from another dotfiles repository, adapt the idea to this environment instead of copying machine-specific paths or assumptions.
