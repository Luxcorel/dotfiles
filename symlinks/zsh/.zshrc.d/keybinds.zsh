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
