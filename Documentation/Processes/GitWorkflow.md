---
title: Git workflow
status: Active
owner: Engineering Manager
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../../CLAUDE.md, ReleaseManagement.md, ../Standards/DocumentationStandards.md]
---

# Git workflow

How code moves from a branch to a release. These rules apply to humans and agents equally.

## Branching

The canonical branch rules are in [../Standards/BranchingStrategy.md](../Standards/BranchingStrategy.md); the essentials, as they sit in the workflow:

- `main` is always releasable. Never commit to it directly.
- Branch from `main` for every unit of work.
- Names: `feature/<short-desc>`, `fix/<short-desc>`, `docs/<short-desc>`, `refactor/<short-desc>`, `perf/<short-desc>`, `hotfix/<short-desc>`.
- One branch per issue. Keep branches short-lived; rebase on `main` rather than letting them drift.

## Commits

The canonical commit rules are in [../Standards/CommitConvention.md](../Standards/CommitConvention.md). Conventional Commits. The format:

```
type(scope): imperative summary under 72 characters

Optional body explaining why the change was made, wrapped at 72 columns.
Reference the issue: Closes #123.

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
```

Types:

| Type | Use for |
|---|---|
| `feat` | A user-visible feature |
| `fix` | A bug fix |
| `refactor` | A change that does not alter behavior |
| `perf` | A change that improves performance |
| `docs` | Documentation only |
| `test` | Tests only |
| `build` | Build system, dependencies, project file |
| `chore` | Tooling and housekeeping |

Scope is the subsystem: `feat(widgets):`, `fix(window):`, `perf(rendering):`.

Rules:

- One logical change per commit. A refactor and a behavior change are two commits.
- The summary is imperative: "add", not "added" or "adds".
- The body explains why. The diff already shows what.
- Never commit or push unless the user asks.

## Pull requests

- A PR targets `main` and follows `.github/PULL_REQUEST_TEMPLATE.md`.
- It is small and single-purpose. A PR that does three things is three PRs.
- It states what changed and why, links the issue, lists the tests, and names the documentation it updated.
- It declares performance and security impact when there is any.
- CI must be green: build, tests, and Markdown lint.

## Code review

- At least one approval before merge.
- The reviewer runs the review checklist in [/CLAUDE.md](../../CLAUDE.md).
- Review comments are specific and actionable. "This could be cleaner" is not a review comment.
- The author resolves every thread or records why it was not addressed.

## Merge strategy

- Squash and merge. One PR becomes one commit on `main`, with a Conventional Commit message.
- The squashed message is the PR title in Conventional form plus the issue reference.
- Delete the branch on merge.

## Versioning and tagging

Semantic Versioning, defined in full in [ReleaseManagement.md](ReleaseManagement.md):

- `MAJOR.MINOR.PATCH`.
- MAJOR for breaking changes to the plugin API or saved data formats.
- MINOR for backward-compatible features.
- PATCH for backward-compatible fixes.
- Tag releases `v1.2.0` on `main`, annotated, after the release checklist passes.

## Release

The release process is in [ReleaseManagement.md](ReleaseManagement.md). At a high level: cut a release branch if stabilization is needed, run the release checklist, tag, build, sign, notarize, write notes, update the Notion Documentation Index and the changelog.

## Hotfix

- Branch `hotfix/<short-desc>` from the release tag, not from `main` if `main` has moved ahead.
- Fix, test, and add a regression test.
- Tag a PATCH release.
- Merge the hotfix back into `main` so the fix is not lost.
