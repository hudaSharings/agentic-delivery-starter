---
name: spec-driven-delivery
description: Run a tracker story through the full pipeline — refine, spec and test cases, test-first, build and E2E automation, PR, review, verify in test, release. Use when asked to "ship", "deliver", or "take <KEY> end to end". Stops at every human gate instead of pushing through it.
---

# Spec-Driven Delivery

This skill is the orchestration layer over `.claude/agents/` and `.claude/commands/`. **Five stages end at a human gate that this skill cannot pass.** Reaching a gate means stopping and reporting status, not carrying on as if approval were implied.

## How to run it

1. **Confirm the story key.** If the user says "ship the next one", ask which key before doing anything.
2. Run `/refine <KEY>`. Report what was posted. **Stop at gate 1:** the product owner marks the story Ready.
3. When told it's ready, run `/spec` and `/test-cases` **in the same message**; they're independent. Then:
   - `ready-for-approval`: **stop at gate 2.** The tech lead approves the spec and the QA lead approves the test cases.
   - Requirement change: **stop.** It goes back to gate 1.
   - `blocked-on-docs`: run `/docs-pr <KEY>` and **stop**. A human merges the design PR. Then run `/docs-bump <KEY>` and `/spec <KEY>` again, and **stop at gate 2**.
4. When told both are approved, run `/write-tests`, then `/build-backend`, `/build-frontend` and `/write-e2e` **in parallel**.
5. Run `/open-pr <KEY>`, then `/review <PR>`. Report the findings. **Stop at gate 3:** a peer approves and merges the PR, even if there were zero findings.
6. If CI fails, the pipeline fixer proposes a fix; the developer accepts it.
7. When told the story is merged and deployed to test, run `/qa-verify <KEY>`. **Stop at gate 4:** the QA lead marks it QA Passed.
8. Run `/release` only when a release is actually being cut. A release bundles many QA-passed stories.

## Never
- Mark a story ready, approve a spec or test cases, approve or merge a PR, mark QA Passed, or approve a release.
- Move tracker statuses. Agents only comment.
- Skip tests-first, or build before gate 2 has been confirmed in this conversation.
- Build against a spec that is still `blocked-on-docs`.
- Fix a contract gap found later in code. Send the story back to stage 2 instead.
