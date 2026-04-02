is_installed nvim || return

todo() {
    local todo_dir="$HOME/.todo"
    if [[ ! -d "$todo_dir" ]]; then
        mkdir -p "$todo_dir" || return 1
    fi

    local filename
    case "$1" in
    +1)
        filename="todo-$(date -v +1d +'%Y-%m-%d').txt" || return 1
        ;;
    -1)
        filename="todo-$(date -v -1d +'%Y-%m-%d').txt" || return 1
        ;;
    *)
        filename="todo-$(date +'%Y-%m-%d').txt" || return 1
        ;;
    esac

    local filepath="$todo_dir/$filename"

    nvim --noplugin "$filepath"
}
