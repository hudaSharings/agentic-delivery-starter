---
description: Open a design-repo PR for the contract changes a blocked spec proposes
argument-hint: <KEY>
allowed-tools: Read, Grep, Glob, Write, Edit, Bash(git -C docs checkout -b:*), Bash(git -C docs add:*), Bash(git -C docs commit:*), Bash(git -C docs push:*), Bash(gh pr create:*)
---

Read the "Proposed docs changes" section of `specs/$ARGUMENTS/spec.md`. In `docs/`, create branch `$ARGUMENTS-docs-<slug>`, edit the canonical contract files directly, push the branch, and open a PR in the design repo that links the story and the spec. Never push to the design repo's `main` and never merge. A human reviews this PR together with the spec at gate 2.
