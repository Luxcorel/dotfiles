# --- setup helper functions ---
case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
'darwin')
  RUNNING_ON="mac"
  ;;
*)
  RUNNING_ON="linux"
  ;;
esac

have_program() {
  local program="$1"
  if command -v "$program" >/dev/null 2>/dev/null; then
    return 0
  else
    return 1
  fi
}

have_mac() {
  if [ "$RUNNING_ON" = "mac" ]; then
    return 0
  else
    return 1
  fi
}

# --- zsh options ---
setopt inc_append_history # continuously append history file entries
setopt extended_history   # include timestamp + execution time in history file
setopt hist_ignore_dups   # skip adding history entry if it's the same as the last one
setopt no_beep            # disable terminal beep
setopt hist_ignore_space  # exclude commands prefixed with a space from history
setopt hist_reduce_blanks # exclude newlines from history

# --- history ---
export HISTSIZE=100000
export SAVEHIST=100000
export HISTORY_IGNORE="(ls|ls *|ll|ll *|cd|cd *|pwd|exit|date|* --help|* -h|n|nnn|vim|vim *|man *|history|history *|idea|idea *|zed|zed *|mpv|mpv *|fg|fg *|clear)"

# --- prompt ---
#default prompt: '%n@%m %1~ %# '
export PROMPT='%(4c?../%2~?%~) %(!.#.>) '

# --- auto-completions ---
autoload -U compinit
compinit
have_program fzf && source <(fzf --zsh) # Set up fzf key bindings and fuzzy completion

# --- keybinds ---
bindkey '^p' history-search-backward # type command and press CTRL+P to see previous usage
bindkey '^n' history-search-forward

# --- aliases ---
have_mac && {
  alias idea="open -na \"IntelliJ IDEA.app\"" # alias for intellij
  alias c="tr -d '\n' | pbcopy"               # macos clipboard copy
  alias v="pbpaste"                           # macos clipboard paste
}
have_program bat && alias cat="bat --theme Coldark-Dark" # replace cat with bat
have_program nvim && alias vim="nvim"
have_program terraform && alias tf="terraform"
alias ll="ls -ahlF --color=auto"
alias grep="grep --color"

# --- misc environment variables ---
export LANG="en_US.UTF-8"
have_program nvim && export EDITOR=nvim
have_program nvim && export VISUAL=nvim

# --- functions ---
if have_mac; then
  # macos pomodoro timer
  pomo() {
    local cycles=4
    local work_time=1500 # 25 min (in seconds)
    local rest_time=300  # 5 min (in seconds)

    # shortcuts focus_on and focus_off will be run if they exist
    local has_focus_shortcuts=false
    shortcuts list | grep -q "^focus_on$" && shortcuts list | grep -q "^focus_off$" && has_focus_shortcuts=true

    convert_to_sec() {
      local duration="$1"
      case "$duration" in
      *m)
        echo $((${duration%m} * 60))
        ;;
      *h)
        echo $((${duration%h} * 3600))
        ;;
      *)
        echo "$duration"
        ;;
      esac
    }

    while [ $# -gt 0 ]; do
      case "$1" in
      -c | --cycles)
        if [ "$2" ]; then
          cycles="$2"
          shift 2
        else
          echo "Use 'pomo -h' for usage"
          return 1
        fi
        ;;
      -w | --work-time)
        if [ "$2" ]; then
          work_time=$(convert_to_sec "$2")
          shift 2
        else
          echo "Use 'pomo -h' for usage"
          return 1
        fi
        ;;
      -r | --rest-time)
        if [ "$2" ]; then
          rest_time=$(convert_to_sec "$2")
          shift 2
        else
          echo "Use 'pomo -h' for usage"
          return 1
        fi
        ;;
      -h | --help)
        echo "Usage: pomo [OPTIONS]"
        echo ""
        echo "OPTIONS"
        echo "  -c, --cycles CYCLES       Number of cycles (default: 4)"
        echo "  -w, --work-time TIME      Work time (Example: 25m, 2h, 1500s) (default: 25m)"
        echo "  -r, --rest-time TIME      Rest time (Example: 5m, 1h, 300s) (default: 5m)"
        echo "  -h, --help                Show help"
        return 0
        ;;
      *)
        echo "Invalid option: $1"
        echo "Use 'pomo -h' for usage"
        return 1
        ;;
      esac
    done

    for ((i = 1; i <= cycles; i++)); do
      echo "Work session $i/$cycles..."
      $has_focus_shortcuts && shortcuts run "focus_on"
      sleep "$work_time"
      osascript -e 'display notification "" with title "Work Timer is up" subtitle "Take a Break!" sound name "Crystal"'

      echo "Rest session $i/$cycles..."
      $has_focus_shortcuts && shortcuts run "focus_off"
      sleep "$rest_time"
      osascript -e 'display notification "" with title "Break is over" subtitle "Back to work!" sound name "Crystal"'
    done

    $has_focus_shortcuts && shortcuts run "focus_off"
    osascript -e 'display notification "" with title "Pomodoro Complete" subtitle "Well done!" sound name "Crystal"'
  }
fi

# --- local config ---
if [ -e "$HOME/.localrc" ]; then
  source "$HOME/.localrc"
fi

have_program zoxide && eval "$(zoxide init --cmd cd zsh)" # replace cd with zoxide

# clean up helper functions
unset -v $RUNNING_ON
unset -f have_program
unset -f have_mac
