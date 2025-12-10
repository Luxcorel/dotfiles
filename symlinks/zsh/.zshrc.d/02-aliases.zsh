# --- aliases ---
is_macos && {
  alias idea="open -na \"IntelliJ IDEA.app\"" # alias for intellij
  alias c="tr -d '\n' | pbcopy"               # macos clipboard copy
  alias v="pbpaste"                           # macos clipboard paste
}

is_installed eza && alias ll="eza -al --icons --git"
! is_installed eza && alias ll="ls -ahlF --color=auto"
is_installed bat && alias cat="bat --theme Coldark-Dark"
is_installed nvim && alias vim="nvim"
is_installed terraform && alias tf="terraform"
is_installed grep && alias grep="grep --color"
is_installed fd && alias ls-nodemodules="fd -I -t d --prune node_modules ."
