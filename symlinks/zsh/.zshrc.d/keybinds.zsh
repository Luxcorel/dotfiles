# --- Snippets ---

# [<CTRL>+x gc]: git commit -m ""
bindkey -s '^xgc' 'git commit -m ""\C-b'

# --- Hotkeys ---

# [<CTRL>+x gs]: git status
bindkey -s '^xgs' 'git status\n'

is_installed gg && {
	# [<CTRL>+gg]: gg
	bindkey -s '^g^g' 'gg\n'
}

# --- Ghostty ---
bindkey "^[[1;5C" forward-word   # Ctrl+Right
bindkey "^[[1;5D" backward-word  # Ctrl+Left
