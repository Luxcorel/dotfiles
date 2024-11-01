# --- history ---
HISTSIZE=100000
SAVEHIST=100000
HISTORY_IGNORE="(ls|ls *|ll|ll *|cd|cd *|pwd|exit|date|* --help|* -h|n|nnn|vim|vim *|man *|history|history *|idea|idea *|zed|zed *|mpv|mpv *)"

# --- zsh options ---
setopt inc_append_history   # continuously append history file entries
setopt extended_history     # include timestamp + execution time in history file
setopt hist_ignore_dups     # skip adding history entry if it's the same as the last one
setopt no_beep              # disable terminal beep
setopt hist_ignore_space    # exclude commands prefixed with a space from history
setopt hist_reduce_blanks   # exclude newlines from history

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

# local config not tracked in git
if [[ -e ~/.localrc ]]
then
  source ~/.localrc
fi

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

# pomodoro timer
pomo() {
    local work_time=1500 # 25 min
    local rest_time=300 # 5 min
    local cycles=${1:-4}

    for ((i=1; i<=cycles; i++)); do
        echo "Work session $i of $cycles..."
        shortcuts run "focus_on"
        sleep "$work_time"
        osascript -e 'display notification "" with title "Work Timer is up" subtitle "Take a Break!" sound name "Crystal"'

        echo "Rest session $i of $cycles..."
        shortcuts run "focus_off"
        sleep "$rest_time"
        osascript -e 'display notification "" with title "Break is over" subtitle "Back to work!" sound name "Crystal"'
    done

    shortcuts run "focus_off"
    osascript -e 'display notification "" with title "Pomodoro Complete" subtitle "Well done!" sound name "Crystal"'
}

# replace cd with zoxide
eval "$(zoxide init --cmd cd zsh)"
