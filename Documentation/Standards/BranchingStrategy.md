---
title: Branching strategy
status: Active
owner: Engineering Manager
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../Processes/GitWorkflow.md, CommitConvention.md, NamingConventions.md]
---

# Branching strategy

The canonical rules for branches. The end-to-end process that uses them, from branch to release, is in [../Processes/GitWorkflow.md](../Processes/GitWorkflow.md); this document is the rule reference it points to.

## Model

Trunk-based with short-lived branches off `main`.

- `main` is always releasable. Never commit to it directly.
- Every unit of work gets its own branch off `main`.
- Branches are short-lived. Rebase on `main` rather than letting a branch drift.
- One branch per issue or logical unit.

## Names

`<type>/<short-kebab-description>`, where type is one of:

| Prefix | For |
|---|---|
| `feature/` | A user-visible feature |
| `fix/` | A bug fix |
| `docs/` | Documentation only |
| `refactor/` | Behavior-preserving change |
| `perf/` | Performance change |
| `hotfix/` | Urgent fix branched from a release tag |

Examples: `feature/live-wallpaper-engine`, `fix/widget-clipping-multimonitor`, `docs/adr-window-levels`.

## Release and hotfix branches

- For a release that needs stabilization, cut `release/x.y` from `main`; only fixes go onto it.
- A hotfix branches `hotfix/<desc>` from the release tag, and merges back to `main` so the fix is not lost.

## Merge

Squash and merge, one branch into one commit on `main`, then delete the branch. The squashed message follows [CommitConvention.md](CommitConvention.md). The full merge and review rules are in [../Processes/GitWorkflow.md](../Processes/GitWorkflow.md).
