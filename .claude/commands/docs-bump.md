---
description: Bump the docs/ submodule to the merged design commit, as its own commit
argument-hint: <KEY>
allowed-tools: Bash(git -C docs fetch:*), Bash(git -C docs checkout:*), Bash(git -C docs log:*), Bash(git add docs), Bash(git commit:*)
---

Confirm the design PR for $ARGUMENTS is merged into the design repo's `main`. Point `docs/` at that commit and make a commit of its own on the story branch: `$ARGUMENTS docs: bump to <short-sha>`. Never pin an unmerged commit, and never mix this change into a feature commit.
