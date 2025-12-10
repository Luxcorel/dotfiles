# source config files in ~/.zshrc.d
zshrc_dir=~/.zshrc.d
if [ -d "$zshrc_dir" ]; then
  for file in "$zshrc_dir"/*.zsh; do
    [ -f "$file" ] && source "$file"
  done
fi

# --- local config ---
if [ -f "$HOME/.localrc" ]; then
  source "$HOME/.localrc"
fi
