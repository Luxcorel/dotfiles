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
export HISTORY_IGNORE="(ls|ls *|ll|ll *|cd|cd *|pwd|exit|bye|zellij|date|* --help|* -h|n|nnn|vim|vim *|man *|history|history *|idea|idea *|zed|zed *|mpv|mpv *|fg|fg *|clear|gg|gg *|iina|iina *)"

# --- prompt ---
#default prompt: '%n@%m %1~ %# '
export PROMPT='%(4c?../%2~?%~) %(!.#.>) '

# --- auto-completions ---
autoload -Uz compinit
compinit
is_installed fzf && source <(fzf --zsh) # Set up fzf key bindings and fuzzy completion

# --- keybinds ---
bindkey '^p' history-search-backward # type command and press CTRL+P to see previous usage
bindkey '^n' history-search-forward
