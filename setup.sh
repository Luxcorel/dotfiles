#!/bin/sh

# install homebrew (automatically installs xcode command line tools)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# for apple silicon:
echo "# Set PATH, MANPATH, etc., for Homebrew." >> ~/.zprofile
echo "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" >> ~/.zprofile
source ~/.zprofile

# install brewfile
brew bundle --file=./homebrew/Brewfile

# create .localrc file if it doesn't exist
touch ~/.localrc

# create symlinks with stow
cd ./symlinks && stow -t ~/ . && cd ..
