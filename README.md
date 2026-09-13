# my-config-files

Personal configuration files for my Fedora Linux development environment.

The goal of this repository is to make my workstation reproducible, understandable, and easy to restore after a clean installation.

Rather than keeping configuration scattered across the home directory, configuration files live in this Git repository and are linked to the locations expected by applications.

## Current setup

The repository currently manages:

* Zsh configuration
* shell history and aliases
* Zsh completion
* command autosuggestions
* syntax highlighting
* history prefix search
* Git-aware shell prompt
* lazy Conda initialization
* Fastfetch startup and configuration
* safe symbolic-link deployment

Future configuration will include tools such as Neovim/LazyVim, Ghostty, data-science tooling, and Claude Code integration.

## Repository structure

```text
my-config-files/
├── AGENTS.md
├── CLAUDE.md
├── README.md
├── fastfetch/
│   └── config.jsonc
├── ghostty/
├── nvim/
├── scripts/
│   └── link-configs.sh
└── zsh/
    ├── .zshenv
    └── .zshrc
```

## How it works

Applications expect configuration in standard locations such as:

```text
~/.zshrc
~/.zshenv
~/.config/fastfetch/config.jsonc
```

The repository keeps the real configuration files under:

```text
~/my-config-files/
```

The deployment script creates symbolic links from the normal configuration locations to the files stored in this repository.

For example:

```text
~/.zshrc
    -> ~/my-config-files/zsh/.zshrc
```

This means editing the file in the Git repository immediately changes the configuration used by Zsh.

## Installation

Clone the repository:

```bash
git clone https://github.com/mintzas/my-config-files.git ~/my-config-files
cd ~/my-config-files
```

Install the current Fedora dependencies:

```bash
sudo dnf install zsh fastfetch zsh-autosuggestions zsh-syntax-highlighting
```

Deploy the configuration:

```bash
./scripts/link-configs.sh
```

The linker is designed to be safe to rerun.

If a configuration file already exists and is not already linked correctly, it is backed up under:

```text
~/.local/state/my-config-files/backups/
```

before the new symbolic link is created.

## Zsh

Zsh is the primary shell.

The configuration is split into:

```text
zsh/.zshenv
zsh/.zshrc
```

`.zshenv` contains minimal environment and PATH configuration.

`.zshrc` contains interactive shell features such as aliases, completion, history, prompt configuration, Conda integration, and Fastfetch startup.

## Conda

Miniconda is expected at:

```text
$HOME/miniconda3
```

Conda is lazy-loaded.

Normal Zsh startup does not fully initialize Conda. The first `conda` command loads the Zsh integration and then executes the requested command.

This keeps ordinary shell startup lightweight.

## Fastfetch

Fastfetch displays a summary of the workstation when an interactive Zsh session starts.

Its version-controlled configuration is stored at:

```text
fastfetch/config.jsonc
```

and linked to:

```text
~/.config/fastfetch/config.jsonc
```

## Security

Secrets must never be committed to this repository.

This includes:

* API keys
* access tokens
* passwords
* SSH private keys
* `.env` files
* local authentication files

Machine-specific secrets should be loaded from secure local storage or environment variables instead.

## Design principles

Configuration should be portable and use `$HOME` or XDG paths rather than hardcoded usernames.

Changes should be understandable, minimal, and tested before deployment.

The repository should remain safe to clone and use on a new Fedora workstation.
# my-config-files
