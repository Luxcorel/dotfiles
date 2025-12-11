#!/usr/bin/env bash

setup_symlinks() {
	log_info() { echo -e "\033[1;32m==>\033[0m $*"; }
	log_error() { echo -e "\033[1;31m[ERROR]\033[0m $*" >&2; }

	log_info "Starting symlink setup..."

	if ! command -v stow &>/dev/null; then
		log_error "GNU Stow is not installed. Exiting."
		return 0
	fi

	for package_path in ./*; do
		if [[ ! -d "$package_path" ]]; then
			continue
		fi

		local package_name
		package_name=$(basename "$package_path")

		log_info "Linking package: $package_name"

		if ! stow -t "$HOME" "$package_name"; then
			log_error "Stow failed for package '$package_name'"
		fi
	done
}
setup_symlinks
