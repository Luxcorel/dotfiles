# --- misc environment variables ---
export LANG="en_US.UTF-8"
is_installed nvim && export EDITOR=nvim
is_installed nvim && export VISUAL=nvim

is_installed fnm && {
	eval "$(fnm env --shell zsh)"
}

is_macos && {
  export PNPM_HOME="$HOME/Library/pnpm"
  if [ -d "$PNPM_HOME" ]; then
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
  fi
}
