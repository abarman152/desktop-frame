---
title: Architecture Decision Records
status: Active
owner: Principal Engineer
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-12-26
related: [ADR-0000-record-architecture-decisions.md, ../Templates/DecisionRecord.md]
---

# Architecture Decision Records

An ADR captures one significant technical decision: the context, the options, the choice, and the consequences. ADRs are how Desktop Frame remembers why it is built the way it is, so a contributor arriving a year from now can understand a decision without asking the person who made it.

## When to write one

Write an ADR when a decision:

- Affects the architecture or a public interface.
- Is expensive or hard to reverse.
- Picks one approach where reasonable engineers would pick differently.
- Constrains future work.

Routine choices that fit existing patterns do not need an ADR. A decision that changes a pattern does.

## Rules

- One decision per file, named `ADR-NNNN-kebab-title.md`, numbered in sequence.
- Copy the structure from [../Templates/DecisionRecord.md](../Templates/DecisionRecord.md).
- An ADR is immutable after it reaches `Accepted`. To change a decision, write a new ADR that supersedes it.
- A superseded ADR sets `status: Superseded` and links forward to the ADR that replaces it. The new ADR links back.
- Every ADR records its owner and decision date.

## Statuses

| Status | Meaning |
|---|---|
| Proposed | Written, under discussion |
| Accepted | Decided and in force |
| Deprecated | No longer recommended, not yet replaced |
| Superseded | Replaced by a later ADR, which is linked |
| Rejected | Considered and declined; kept for the record |

## Lifecycle

1. An engineer or the architect agent writes a Proposed ADR on a branch.
2. It is reviewed like code. Discussion happens in the PR.
3. On agreement it becomes Accepted and merges.
4. If a later decision changes it, a new ADR supersedes it. The original is never deleted.

## Index

ADRs are listed here as they are accepted, newest first.

| ADR | Title | Status | Date |
|---|---|---|---|
| 0000 | Record architecture decisions | Accepted | 2026-06-26 |

The Notion Engineering section mirrors this index for project-management visibility. The files here are canonical.
