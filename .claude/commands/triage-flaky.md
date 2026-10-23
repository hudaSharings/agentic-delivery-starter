---
description: Triage a failed nightly test run
argument-hint: [run-id]
allowed-tools: Task
---

Use the `flaky-test-triager` subagent on CI run $ARGUMENTS (or the latest failed nightly run). Report the defects filed, the quarantine PRs opened, and the environment issues found.
