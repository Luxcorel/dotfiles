# --- set up helper functions ---
case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
'darwin')
  RUNNING_ON="mac"
  ;;
*)
  RUNNING_ON="linux"
  ;;
esac

is_installed() {
  local program="$1"
  if command -v "$program" >/dev/null 2>/dev/null; then
    return 0
  else
    return 1
  fi
}

is_macos() {
  if [ "$RUNNING_ON" = "mac" ]; then
    return 0
  else
    return 1
  fi
}

