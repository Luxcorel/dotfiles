# Dotfiles for macOS & Linux

# Overview

```text
.
├── homebrew/Brewfile    # Homebrew brewfile
├── iterm2/              # iTerm2 config
├── symlinks/            # Stow packages (symlinked under ~/)
│   ├── zsh/
│   │   │── .zshrc       # zsh config loader
│   │   └── .zshrc.d/    # zsh configs
│   ...
│   └── symlink.sh       # Script for symlinking stow package
└── setup.sh             # Auto-setup script for macOS
```

# Setup

## Auto-setup script (macOS)

```sh
git clone --recurse-submodules https://github.com/Luxcorel/dotfiles ~/.dotfiles && cd ~/.dotfiles && ./setup.sh
```

## Symlink script (macOS or Linux)

```sh
git clone --recurse-submodules https://github.com/Luxcorel/dotfiles ~/.dotfiles && cd ~/.dotfiles/symlinks && ./symlink.sh
```
