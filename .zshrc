# alias for intellij
alias idea="open -na \"IntelliJ IDEA.app\""

# replace cd with zoxide
eval "$(zoxide init --cmd cd zsh)"

# replace cat with bat
alias cat=bat

# nvim alias
alias vim=nvim

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
