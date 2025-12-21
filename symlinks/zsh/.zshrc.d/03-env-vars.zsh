# --- misc environment variables ---
export LANG="en_US.UTF-8"
is_installed nvim && export EDITOR=nvim
is_installed nvim && export VISUAL=nvim

is_installed fnm && {
	eval "$(fnm env --shell zsh)"
}

is_macos && {
	if [ -d "$HOME/Library/pnpm" ]; then
		export PNPM_HOME="$HOME/Library/pnpm"

		case ":$PATH:" in
		*":$PNPM_HOME:"*) ;;
		*) export PATH="$PNPM_HOME:$PATH" ;;
		esac
	fi
}
