---
title: ADR-0000 Record architecture decisions
status: Accepted
owner: Principal Engineer
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-12-26
related: [README.md, ../Templates/DecisionRecord.md]
---

# ADR-0000: Record architecture decisions

## Status

Accepted — 2026-06-26.

## Context

Desktop Frame is intended to be developed for years by a changing set of human and AI contributors. Decisions made early (the desktop window level, actor-isolated services, `@Observable` over `ObservableObject`) shape everything built later. Without a record of why each was made, future contributors either re-litigate settled questions or break an invariant they did not know existed. Commit messages and Notion pages are too scattered and too mutable to serve as that record.

## Problem

How do we record significant technical decisions so they are durable, reviewable, versioned alongside the code, and auditable years later.

## Alternatives considered

1. Commit messages only. Cheap, but unsearchable as a body of decisions and easy to miss.
2. A Notion decisions database only. Visible to project management, but mutable, not version-controlled, and divorced from the code it governs.
3. A single growing DECISIONS.md. Simple, but it becomes a merge-conflict magnet and loses the one-decision-per-record discipline.
4. Architecture Decision Records: one immutable Markdown file per decision, in the repository, reviewed like code.

## Decision

Adopt Architecture Decision Records in `Documentation/Decisions/`, one file per decision, immutable after acceptance, superseded rather than edited. The format and lifecycle are defined in [README.md](README.md) and the template in [../Templates/DecisionRecord.md](../Templates/DecisionRecord.md). The Notion Engineering section mirrors the index for visibility; the files here are canonical.

## Trade-offs

Writing an ADR costs time and discipline at the moment of decision. In exchange, the project gains a durable, diffable, reviewable decision history that travels with the code and survives contributor turnover. For a multi-year project with AI agents that start each task without memory, that history is worth the cost.

## Consequences

- Every significant decision from now on is recorded here before or as it is implemented.
- The earliest decisions already made during scaffolding are back-filled as ADRs 0001 onward.
- Changing a decision means writing a new ADR, not editing an old one.
- Agents must check the relevant ADRs before changing architecture, per [/CLAUDE.md](../../CLAUDE.md).

## References

1. Michael Nygard, "Documenting Architecture Decisions" (the original ADR pattern). https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions
