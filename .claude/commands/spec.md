---
description: Stage 2 — write specs/<KEY>/spec.md from a ready story
argument-hint: <KEY>
allowed-tools: Task
---

Use the `lld-author` subagent to write `specs/$ARGUMENTS/spec.md`. The story must already be ready; if it is not, stop and say so. Report the status the spec ends in, and the next step:

- `ready-for-approval`: the tech lead approves it (gate 2).
- `blocked-on-docs`: run `/docs-pr $ARGUMENTS`; after a human merges that PR, run `/docs-bump $ARGUMENTS`, then `/spec $ARGUMENTS` again to finalise.
- Requirement change: back to the product owner (gate 1).
