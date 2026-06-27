---
title: <feature> technical specification
status: Draft
owner: <engineer>
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
related: []
---

<!--
TEMPLATE: Technical specification. Copy to the relevant Documentation/ folder.
Follows ../Standards/DocumentationStandards.md. Writing guidance: this is how a
feature will be built, written before implementation and kept true during it.
-->

# <feature> technical specification

## Summary

One paragraph: what is being built and the approach in brief.

## Goals and non-goals

What this delivers, and what it explicitly does not, so scope is bounded.

## Requirements

The functional and non-functional requirements, including the performance and accessibility budgets that apply.

## Design

The implementation approach: types, data structures, algorithms, concurrency. Link the governing architecture document and any ADR.

## Interfaces

The public and internal interfaces this introduces or changes. Note plugin-API impact if any.

## Testing approach

What will be unit-tested, what integration-tested, and the key cases including failure modes.

## Risks and trade-offs

What is uncertain or being traded away, and the mitigation.

## Rollout

How this ships: behind a flag, in stages, or directly. Migration impact on saved data if any.

## References

Sources and links.

## Completion checklist
- [ ] Goals and non-goals bounded.
- [ ] Design ties to an architecture doc or ADR.
- [ ] Interface and plugin-API impact stated.
- [ ] Testing approach covers failure modes.
- [ ] Performance and accessibility budgets addressed.

## Review checklist
- [ ] Implementable as written, no architectural gaps.
- [ ] Risks named with mitigations.
- [ ] Meets DocumentationStandards.
