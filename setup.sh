#!/usr/bin/env bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
IFS=$'\n\t'
set -euo pipefail

# --- utility functions ---
log_info() { echo -e "\033[1;32m==>\033[0m $*"; }
log_warn() { echo -e "\033[1;33m[WARN]\033[0m $*"; }
log_error() { echo -e "\033[1;31m[ERROR]\033[0m $*" >&2; }

# trap errors to display a message before exiting
trap 'log_error "Script failed at line $LINENO. Exiting..."' ERR

# run script from its directory
cd "$(dirname "$0")"

# --- OS check ---
case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
darwin)
	log_info "Running on macOS."
	;;
*)
	log_error "Not running on macOS."
	# shellcheck disable=SC2317 # fallback to exit if the script was not sourced
	return 1 || exit 1
	;;
esac

# install homebrew
if ! command -v brew &>/dev/null; then
	log_info "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	log_info "Homebrew was already installed."
fi

# set up homebrew for Apple Silicon, if not already configured
if ! grep -q '/opt/homebrew/bin/brew shellenv' ~/.zprofile 2>/dev/null; then
	log_info "Configuring Homebrew environment..."
	echo "# Set PATH, MANPATH, etc., for Homebrew." >>~/.zprofile
	echo "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" >>~/.zprofile
	source ~/.zprofile
fi

# update brew and upgrade packages
log_info "Updating Homebrew..."
brew update && brew upgrade

# install programs using brewfile
if [[ -f ./homebrew/Brewfile ]]; then
	log_info "Installing from Brewfile..."
	brew bundle --file=./homebrew/Brewfile
else
	log_warn "No Brewfile found at ./homebrew/Brewfile"
fi

# tweaks for dock: https://apple.stackexchange.com/a/298826
log_info "Applying Dock tweaks..."
# autohide dock
defaults write com.apple.dock autohide -bool true
# defaults write com.apple.dock autohide -bool false

# disable peeking
defaults write com.apple.dock autohide-delay -float 1000
# defaults delete com.apple.dock autohide-delay

# disable icon bouncing
defaults write com.apple.dock no-bouncing -bool TRUE
# defaults write com.apple.dock no-bouncing -bool FALSE

# restart dock
killall Dock || true

# create .localrc file if it doesn’t exist
[[ -f ~/.localrc ]] || {
	log_info "Creating ~/.localrc"
	touch ~/.localrc
}

# use stow for symlinks if installed
setup_symlinks() {
	log_info "Starting symlink setup..."

	if ! command -v stow &>/dev/null; then
		log_warn "GNU Stow is not installed. Skipping."
		return 0
	fi

	if [[ ! -d "./symlinks" ]]; then
		log_warn "Directory ./symlinks/ not found. Skipping."
		return 0
	fi

	for package_path in ./symlinks/*; do
		if [[ ! -d "$package_path" ]]; then
			continue
		fi

		local package_name
		package_name=$(basename "$package_path")

		log_info "Linking package: $package_name"

		if ! stow -d symlinks -t "$HOME" "$package_name"; then
			log_error "Stow failed for package '$package_name'"
		fi
	done
}
setup_symlinks

log_info "Setup complete!"
