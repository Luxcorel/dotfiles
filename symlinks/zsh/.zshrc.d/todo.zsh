is_installed nvim || return

todo() {
    local todo_dir="$HOME/.todo"
    if [[ ! -d "$todo_dir" ]]; then
        mkdir -p "$todo_dir"
    fi

    local filename
    filename="todo-$(date +'%Y-%m-%d').txt"

    local filepath="$todo_dir/$filename"

    nvim --noplugin "$filepath"
}
