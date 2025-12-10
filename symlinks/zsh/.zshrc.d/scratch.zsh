is_macos || return

tmp() {
    local scratch_dir="$HOME/.scratch"
    if [[ ! -d "$scratch_dir" ]]; then
        mkdir -p "$scratch_dir"
    fi

    local filetype="${1:-txt}"
    local filename="scratch-$(date +'%Y-%m-%d-%H%M%S').$filetype"
    local filepath="$scratch_dir/$filename"

    nvim "$filepath" +startinsert
}
