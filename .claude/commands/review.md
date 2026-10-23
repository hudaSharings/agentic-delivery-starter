---
description: Stage 7 — run code and security review on a PR
argument-hint: <PR-number>
allowed-tools: Task
---

Run the `code-reviewer` and `security-reviewer` subagents on PR $ARGUMENTS in parallel. Report both sets of findings, with blockers first. Even with zero findings, say plainly that a peer must still approve the PR (gate 3).
