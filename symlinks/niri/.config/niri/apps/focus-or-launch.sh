#!/usr/bin/env bash
set -euo pipefail

app_id="$1"
shift

window_id=$(
    niri msg --json windows |
        jq -r --arg app "$app_id" '
            [.[] | select(.app_id == $app)]
            | sort_by([(.is_focused | not), .id])
            | .[0].id // empty
        '
)

if [[ -n "$window_id" ]]; then
    exec niri msg action focus-window --id "$window_id"
fi

exec "$@"
