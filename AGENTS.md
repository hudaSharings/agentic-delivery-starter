# Agent Instructions

Tool-agnostic ([AGENTS.md](https://agents.md)). Every coding agent reads this file. Keep it short: it's loaded on every turn.

## Source of truth

`docs/` (design, git submodule) > tracker story > `specs/<KEY>/spec.md` > code. If code disagrees with a spec, or a spec disagrees with `docs/`, the later one is wrong. Fix it at the source; don't patch around it.

## Non-negotiable rules

Replace these examples with your own. Keep each rule to one line.

1. **Layering:** <e.g. Domain → Application → Infrastructure/API; dependencies point inward only>.
2. **Module boundaries:** <e.g. no module reads another module's database; use its public interface or an event>.
3. **Data isolation:** <e.g. every tenant-scoped table ships its access policy in the same change>.
4. **Sensitive domains:** <e.g. money moves only inside the ledger module>.
5. **Strict TDD** (failing test first, no exceptions) for: <e.g. pricing, payments, auth, data isolation>.
6. **Licences:** <e.g. MIT / Apache-2.0 / BSD only>.
7. **No agent merges to `main` or deploys to production.** Ever.
8. **Secrets never appear in a file, commit, or tool call.**

## Spec-driven delivery

Every story is built from `specs/<KEY>/spec.md` (scope, contract changes, test plan) and `specs/<KEY>/test-cases.md` (what must be proved, and at which layer). Both are written and approved before any code. Five stages always stop for a human: story ready, spec and test cases approved, PR approved, QA passed, release approved. An agent drafts; it never crosses these gates on its own.

**Testing:** test cases come from acceptance criteria, not from the design, at the lowest layer that proves them. End-to-end tests use stable test IDs and seed data only, never production data. Never delete, skip or loosen a failing test. Quarantine a flaky one with a ticket and an expiry date, through a reviewed PR.

**Changing `docs/`:** if a story needs a new or changed contract, change the design repo first. Mark the spec `blocked-on-docs`, open a design PR, have it approved with the spec at gate 2 and merged by a human, then bump the submodule in its own commit. Never edit `docs/` inside a feature change.

## Conventions

Branch `<KEY>-<slug>`. Commits start with the story key. The PR links the story and the spec.
