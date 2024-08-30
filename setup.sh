#!/bin/sh

# install homebrew (automatically installs xcode command line tools)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# for apple silicon: Set PATH, MANPATH, etc., for Homebrew:
echo "eval \"$(/opt/homebrew/bin/brew shellenv)\"" >> ~/.zprofile

# install brewfile
brew bundle --file=./homebrew/Brewfile
