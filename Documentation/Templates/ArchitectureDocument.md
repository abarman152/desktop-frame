---
title: <subsystem> architecture
status: Draft
owner: Principal Engineer
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
related: []
---

<!--
TEMPLATE: Architecture document. Copy to Documentation/Architecture/, fill every
section, remove these comments. Follows ../Standards/DocumentationStandards.md.
Writing guidance: describe the design as it is, and why it is that way. State
invariants explicitly so a future contributor does not break one unknowingly.
-->

# <subsystem> architecture

## Purpose and scope

What this subsystem does and where its boundaries are. What it is not responsible for.

## Context

Where this sits in the larger system. The subsystems it depends on and that depend on it. Link the related architecture documents.

## Design

The structure: the types, their responsibilities, and the interfaces between them. Use a text or Mermaid diagram with a one-line caption. State the concurrency model (which parts are actors, which are `@MainActor`).

## Invariants

The properties that must always hold. Breaking one is a bug even if the build passes. Name them so reviewers can check them.

## Data flow

How data enters, moves through, and leaves the subsystem. A diagram helps.

## Alternatives and decisions

The designs considered and rejected, with links to the governing ADRs.

## Known limitations

What this design does not handle, and why that is acceptable for now.

## References

Numbered external sources and links to related documents and ADRs.

## Completion checklist
- [ ] Purpose, boundaries, and context stated.
- [ ] Design and concurrency model described with a diagram.
- [ ] Invariants named explicitly.
- [ ] Governing ADRs linked.
- [ ] Known limitations recorded.

## Review checklist
- [ ] Matches the implemented code.
- [ ] No decision present here that lacks an ADR.
- [ ] Meets DocumentationStandards.
