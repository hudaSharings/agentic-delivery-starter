# Agentic Delivery Starter Kit

A template that gives AI coding agents a safe way to take a story from requirement to reviewed, tested code. Agents draft; people decide.

It's built for **Claude Code**, with **Jira** and **GitHub** as example integrations. The rules file (`AGENTS.md`) is tool-agnostic, so other agents can use it too.

## Contents

1. [How it works](#how-it-works)
2. [What's in the box](#whats-in-the-box)
3. [Set it up](#set-it-up)
4. [Using another tool](#using-another-tool)
5. [Customise first](#customise-first)

## How it works

One story runs through nine stages. Five of them end at a **human gate** that no agent may pass on its own:

| # | Stage | Command | Gate |
|---|---|---|---|
| 1 | Refine | `/refine <KEY>` | **Product owner: story is Ready** |
| 2 | Spec + test cases (parallel) | `/spec <KEY>`, `/test-cases <KEY>` | **Tech lead + QA lead approve** |
| 3 | Tests first | `/write-tests <KEY>` | reviewed in the PR |
| 4–5 | Build backend, frontend, E2E (parallel) | `/build-backend`, `/build-frontend`, `/write-e2e` | reviewed in the PR |
| 6 | Open PR | `/open-pr <KEY>` | — |
| 7 | Review | `/review <PR>` | **Peer approves the PR** |
| 8 | Fix a failed pipeline | automatic | developer accepts the fix |
| 8b | Verify in test | `/qa-verify <KEY>` | **QA lead: QA Passed** |
| 9 | Release | `/release` | **Release manager approves** |

Say `ship <KEY>` and the `spec-driven-delivery` skill runs these stages in order, stopping at every gate.

Order of truth: `docs/` (design) > tracker story > `specs/<KEY>/spec.md` > code. If a later item disagrees with an earlier one, the later one is wrong.

## What's in the box

```
AGENTS.md                 rules every agent reads (tool-agnostic)
CLAUDE.md                 Claude Code adapter: imports AGENTS.md
.mcp.json                 tracker + code host + browser connections (examples)
.claude/
  settings.json           wires the hooks
  agents/                 14 single-purpose subagents
  commands/               15 slash commands, one per stage
  skills/spec-driven-delivery/SKILL.md   the gated pipeline
  hooks/                  block-dangerous-commands.sh, pre-commit-checks.sh
specs/_template/          spec.md and test-cases.md templates
docs/                     put your design repo here (git submodule)
```

## Set it up

1. **Design repo.** Keep requirements, architecture and contracts (API, schema, events) in their own repo as plain text.
2. **Link it.** In your code repo, run `git submodule add <design-repo-url> docs`.
3. **Copy this kit** into the code repo's root.
4. **Edit `AGENTS.md`.** Replace every `<placeholder>` with your own rules (see [Customise first](#customise-first)).
5. **Connect tools.** Check the MCP URLs in `.mcp.json` against each vendor's current docs. Set `GITHUB_PAT` as an environment variable, scoped to push branches and open PRs, never merge. Run `gh auth login`.
6. **Wire the hooks.** Run `chmod +x .claude/hooks/*.sh`, then set the three commands in `pre-commit-checks.sh` to your formatter, architecture tests and licence scan. The hooks need `jq`.
7. **Protect `main`.** Require CI, one human approval, and code owners for sensitive paths.
8. **Pilot one small story** end to end, then tune the agents based on what went wrong.

## Using another tool

| Layer | Claude Code | Other agent tools |
|---|---|---|
| Rules | `AGENTS.md`, imported by `CLAUDE.md` | Same `AGENTS.md`; many agents read it natively |
| Agents | `.claude/agents/*.md` | The tool's own agent or mode files, or one session per stage |
| Commands | `.claude/commands/` + skill | Saved prompts plus a runbook that stops at each gate |
| Guardrails | PreToolUse hooks | The tool's hooks, else git hooks and server-side rules |
| Connections | `.mcp.json` | Same MCP servers where supported, or CLIs |

To use GitLab instead of GitHub, replace `gh` with `glab` and PR with MR, and move CI to GitLab CI. To use a different tracker, swap the tracker MCP server and the `mcp__atlassian__*` tool names in the agent files. The gates stay the same.

## Customise first

- `AGENTS.md`: your layering rules, data-isolation rule, licence policy, and the areas where test-first is strict.
- `.claude/agents/*.md`: test frameworks and folder names.
- `pre-commit-checks.sh`: your real commands.
- Tool names: the `mcp__atlassian__*` names are examples. Check them against the MCP server version you install.

Licence: MIT. See `LICENSE`.
