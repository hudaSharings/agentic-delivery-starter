---
description: Push the story branch and open a PR linked to its story and spec
argument-hint: <KEY>
allowed-tools: Bash(git push:*), Bash(gh pr create:*)
---

1. Confirm the branch starts with `$ARGUMENTS` and that `specs/$ARGUMENTS/spec.md` is approved. If either check fails, stop.
2. Confirm locally that the build, the tests and the architecture tests pass.
3. Push the branch and open a PR against `main` with `gh pr create`. Start the title with `$ARGUMENTS:` and link the story and the spec in the body.
4. Do not merge, request a merge, or bypass branch protection. Tell the user the PR is ready for `/review`.
