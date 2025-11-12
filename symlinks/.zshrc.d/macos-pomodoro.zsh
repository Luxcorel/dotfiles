[ "$RUNNING_ON" = "mac" ] || {
  return
}

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

    echo "Reset session $i/$cycles..."
    $has_focus_shortcuts && shortcuts run "focus_off"
    sleep "$rest_time"
    osascript -e 'display notification "" with title "Break is over" subtitle "Back to work!" sound name "Crystal"'
  done

  $has_focus_shortcuts && shortcuts run "focus_off"
  osascript -e 'display notification "" with title "Pomodoro Complete" subtitle "Well done!" sound name "Crystal"'
}
