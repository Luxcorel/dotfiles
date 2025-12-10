is_installed fzf || {
  return
}

pinit() {
  readonly supported_currencies=("js-vanilla" "ts-vanilla")

  echo "Init project: "
  choice=$(printf "%s\n" "${supported_currencies[@]}" | fzf --height=50% --layout=reverse)
  if [ -z "$choice" ]; then
    return 1
  fi

  case "$choice" in
  "js-vanilla")
    cat <<EOF >jsconfig.json
  "compilerOptions": {
    "module": "ES6",
    "target": "ES6"
  },
  "exclude": ["node_modules"]
}
EOF
    return 0
    ;;
  "ts-vanilla")
    cat <<EOF >tsconfig.json
  "compilerOptions": {
    "module": "ES6",
    "target": "ES6"
  },
  "exclude": ["node_modules"]
}
EOF
    return 0
    ;;
  *)
    echo "error: unsupported action"
    return 1
    ;;
  esac
}
