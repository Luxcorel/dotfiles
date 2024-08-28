# --- auto-completions ---
autoload -U compinit; compinit
# fzf auto-completion
source "/opt/homebrew/opt/fzf/shell/completion.zsh"

# --- prompt ---
#PROMPT='%n@%m %1~ %# '
PROMPT='%(4c?../%2~?%~) %(!.#.>) '

# --- aliases ---
alias idea="open -na \"IntelliJ IDEA.app\"" # alias for intellij
alias cat="bat --theme Coldark-Dark"        # replace cat with bat
alias vim=nvim
alias ll="ls -ahlF --color=auto"
alias grep="grep --color"
alias c="tr -d '\n' | pbcopy"               # macos clipboard copy
alias v="pbpaste"                           # macos clipboard paste

# --- env vars ---


# --- functions ---

# cheat.sh search
cheat() {
  # select programming language or command using fzf
  category=$(curl -s cheat.sh/:list | fzf --height=50% --layout=reverse)

  # check that something was selected
  if [ -n "$category" ]; then
    # read user input
    read "query?Enter search query:
"
    # replace spaces in user input with '+'
    query=${query// /+}

    if [ -n "$query" ]; then
      curl -s "cheat.sh/$category/$query" | cat
    else
      curl -s "cheat.sh/$category" | cat
    fi

  fi
}

# replace cd with zoxide
eval "$(zoxide init --cmd cd zsh)"
