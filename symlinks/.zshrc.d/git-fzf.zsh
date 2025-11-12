is_installed fzf || {
  return
}

gg() {
  local git_commands=(
    "Status: Show working tree status :: git status"
    "Log (graph): Show compact, graphical log :: git log --oneline --graph --decorate"
    "Log (full): Show full commit log :: git log"
    "Commit: Record changes (opens editor) :: git commit -v"
    "Commit (amend): Amend previous commit :: git commit -v --amend"
    "Push: Update remote repository :: git push"
    "Push (force): Force update remote (use with caution!) :: git push --force-with-lease"
    "Pull: Fetch and integrate (rebase) :: git pull --rebase"
    "Branch: List all branches :: git branch -vv"
    # NOTE: single quotes are used to avoid executing subshell here:
    'Checkout: Switch branches (interactive) :: git checkout $(git branch --format="%(refname:short)" | fzf --height=20% --layout=reverse)'
    "Diff: Show changes (working tree) :: git diff"
    "Diff (staged): Show changes (staged) :: git diff --staged"
    "Add (interactive): Interactively add changes :: git add -p"
    "Add (all): Stage all changes :: git add ."
    "Reset (soft): Unstage changes :: git reset HEAD"
    "Reset (hard): Discard all local changes (use with caution!) :: git reset --hard"
    "Stash: Stash local changes :: git stash"
    "Stash (pop): Re-apply last stash :: git stash pop"
    "Fetch: Fetch from all remotes :: git fetch --all"
    "Remote: List remotes :: git remote -v"
  )

  local choice
  if [ "$1" ]; then
    choice=$(printf "%s\n" "${git_commands[@]}" | fzf --query="$1" --height=50% --layout=reverse)
  else
    choice=$(printf "%s\n" "${git_commands[@]}" | fzf --height=50% --layout=reverse)
  fi
  if [ -z "$choice" ]; then
    return 1
  fi

  local command_to_run
  command_to_run=$(echo "$choice" | awk -F ' :: ' '{print $2}')

  echo "Running: $command_to_run"
  eval "$command_to_run"
}
