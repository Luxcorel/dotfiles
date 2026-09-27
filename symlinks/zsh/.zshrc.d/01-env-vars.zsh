# --- misc environment variables ---
export LANG="en_US.UTF-8"
is_installed nvim && export EDITOR=nvim
is_installed nvim && export VISUAL=nvim

is_installed fnm && {
	eval "$(fnm env --shell zsh)"
}

is_installed cargo && export PATH="$HOME/.cargo/bin:$PATH"

is_macos && {
	if [ -d "$HOME/Library/pnpm" ]; then
		export PNPM_HOME="$HOME/Library/pnpm"

		case ":$PATH:" in
		*":$PNPM_HOME:"*) ;;
		*) export PATH="$PNPM_HOME:$PATH" ;;
		esac
	fi
}

is_linux && {
	case ":$PATH:" in
	  *":$HOME/.local/bin:"*) ;;
	  *) export PATH="$PATH:$HOME/.local/bin" ;;
	esac

	if [ -d "$HOME/.local/share/pnpm" ]; then
		export PNPM_HOME="$HOME/.local/share/pnpm"
		case ":$PATH:" in
		  *":$PNPM_HOME/bin:"*) ;;
		  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
		esac
	fi
}
