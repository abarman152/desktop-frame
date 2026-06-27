---
title: Review checklist
status: Active
owner: Principal Engineer
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../../CLAUDE.md, ../Processes/QualityGates.md]
---

# Review checklist

The checklist a reviewer runs on every pull request. It is the per-change expression of the [QualityGates.md](../Processes/QualityGates.md); the gates define the bars, this checklist is what a human or agent ticks during review. The same list appears in [/CLAUDE.md](../../CLAUDE.md) so an agent has it at hand; this document is its canonical home.

## Correctness and code

- [ ] Builds with zero new warnings under strict concurrency.
- [ ] No force unwrap without a documented invariant; no silent error swallowing.
- [ ] No `DispatchQueue.main.async`; isolation is correct.
- [ ] One logical change; refactor and behavior change are not mixed.
- [ ] Names and structure follow [NamingConventions.md](NamingConventions.md) and [SwiftStyleGuide.md](SwiftStyleGuide.md).

## Tests

- [ ] Unit and integration tests added or updated and passing.
- [ ] A bug fix includes a test that fails without the fix.
- [ ] No flaky or assertion-free tests introduced.

## Performance and security

- [ ] Performance budget not regressed; measured if in a hot path ([PerformanceStandards.md](PerformanceStandards.md)).
- [ ] Public APIs only; data on device or explicit consent ([SecurityStandards.md](SecurityStandards.md)).

## Accessibility and UX

- [ ] New interactive elements have labels; Reduce Motion and Reduce Transparency respected ([AccessibilityStandards.md](AccessibilityStandards.md)).
- [ ] Matches the accepted spec; no interaction regression.

## Documentation and decisions

- [ ] Public and internal declarations documented.
- [ ] Affected documentation updated in the same change.
- [ ] An ADR is written if architecture changed.
- [ ] The Notion Documentation Index updated if a doc was added.

## Process

- [ ] Conforms to the matching `.agents/` role definition.
- [ ] Commit and branch follow [CommitConvention.md](CommitConvention.md) and [BranchingStrategy.md](BranchingStrategy.md).
- [ ] Every checklist item passes, or has a written, accepted exception.
