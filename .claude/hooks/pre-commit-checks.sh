#!/bin/bash
# PreToolUse hook on Bash, active only for `git commit`. Runs CI's cheapest
# gates before the commit exists. Exit 2 blocks the commit.
set -euo pipefail

command=$(jq -r '.tool_input.command // ""')
case "$command" in *"git commit"*) ;; *) exit 0 ;; esac

cd "${CLAUDE_PROJECT_DIR:-.}"

# Replace these with your real commands. Leave a value empty to skip that
# gate with a warning (useful until the tooling exists).
FORMAT_CMD=""        # e.g. "npm run format:check" or "dotnet format --verify-no-changes"
ARCH_TEST_CMD=""     # e.g. "npm run test:architecture"
LICENCE_CMD=""       # e.g. "./scripts/licence-scan.sh"

run_gate() {
  local name="$1" cmd="$2"
  if [ -z "$cmd" ]; then echo "WARNING: skipped $name gate (not configured)" >&2; return 0; fi
  bash -c "$cmd" || { echo "BLOCKED by pre-commit-checks.sh: $name failed" >&2; exit 2; }
}

run_gate "format" "$FORMAT_CMD"
run_gate "architecture" "$ARCH_TEST_CMD"
run_gate "licence" "$LICENCE_CMD"
exit 0
