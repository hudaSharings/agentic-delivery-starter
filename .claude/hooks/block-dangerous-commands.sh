#!/bin/bash
# PreToolUse hook on Bash. Blocks commands no agent session should run,
# whoever asked. Exit 2 = block (stderr goes back to the agent); exit 0 = allow.
set -euo pipefail

command=$(jq -r '.tool_input.command // ""')

deny() { echo "BLOCKED by block-dangerous-commands.sh: $1" >&2; exit 2; }

case "$command" in
  *"gh pr merge"*|*"glab mr merge"*)
    deny "merging is a human gate — agents open PRs, they never merge them." ;;
  *"push --force"*main*|*"push -f"*main*|*"push --force"*master*|*"push -f"*master*)
    deny "force-push to the default branch is never allowed." ;;
  *"git push"*" main"*|*"git push"*":main"*|*"git push"*" master"*|*"git push"*":master"*)
    deny "work happens on the story branch; never push to the default branch." ;;
  *"git -C docs push"*)
    case "$command" in *main*|*master*) deny "design changes go through a design-repo PR (/docs-pr)." ;; esac ;;
  *"git reset --hard"*origin/*)
    deny "discarding history is never allowed from an agent session." ;;
  *"rm -rf /"*|*"rm -rf ~"*)
    deny "rm -rf on a root or home path is never allowed." ;;
  *psql*prod*|*PGHOST=prod*|*--host=prod*)
    deny "no direct production database access — use the migration pipeline." ;;
esac
exit 0
