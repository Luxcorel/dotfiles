#!/usr/bin/env bash

# install homebrew (should automatically install xcode command line tools)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# set up homebrew for apple silicon
echo "# Set PATH, MANPATH, etc., for Homebrew." >>~/.zprofile
echo "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" >>~/.zprofile
source ~/.zprofile

# install programs according to brewfile
brew bundle --file=./homebrew/Brewfile

# create .localrc file
touch ~/.localrc

# create symlinks with stow
stow -t ~/ ./symlinks
