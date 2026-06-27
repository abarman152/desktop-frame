---
title: Commit convention
status: Active
owner: Engineering Manager
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../Processes/GitWorkflow.md, BranchingStrategy.md]
---

# Commit convention

The canonical commit-message rules. The workflow that applies them is in [../Processes/GitWorkflow.md](../Processes/GitWorkflow.md).

## Format

Conventional Commits:

```
type(scope): imperative summary under 72 characters

Optional body explaining why the change was made, wrapped at 72 columns.
Reference the issue: Closes #123.

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
```

## Types

| Type | For |
|---|---|
| `feat` | A user-visible feature |
| `fix` | A bug fix |
| `refactor` | A behavior-preserving change |
| `perf` | A performance improvement |
| `docs` | Documentation only |
| `test` | Tests only |
| `build` | Build system, dependencies, project file |
| `chore` | Tooling and housekeeping |

## Scope

The subsystem the change touches: `feat(widgets):`, `fix(window):`, `perf(rendering):`, `docs(adr):`. Scope is optional only when no single subsystem applies.

## Rules

- One logical change per commit. A refactor and a behavior change are two commits.
- The summary is imperative: "add", not "added" or "adds".
- The body explains why, not what; the diff shows what.
- A breaking change is marked with `!` after the type or scope, and explained in the body: `feat(api)!: remove deprecated widget hook`.
- Never commit or push unless the user asks.

## Why this convention

Conventional Commits make history readable, let releases and changelogs be derived from commits, and force one logical change per commit. The changelog categories in [../Templates/ChangelogEntry.md](../Templates/ChangelogEntry.md) map directly to these types.
