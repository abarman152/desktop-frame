---
title: ADR-0011 Swift 6 strict concurrency and the macOS 15 baseline
status: Accepted
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-12-27
related: [ADR-0002-actor-isolated-system-services.md, ../Development/DevelopmentSetup.md, ../Engineering/GovernanceAuditReport.md]
---

# ADR-0011: Swift 6 strict concurrency and the macOS 15 baseline

## Status

Accepted — 2026-06-27. Resolves gap 1 of the [governance audit](../Engineering/GovernanceAuditReport.md).

## Context

The constitution and `DevelopmentSetup.md` mandate Swift 6, strict concurrency complete, and a macOS 15+ / Apple-Silicon-first target. The governance audit recorded a drift: the Xcode project still declares `SWIFT_VERSION = 5.0` and a lower deployment target. Meanwhile the codebase already relies on Swift-6-era guarantees — `actor` services ([ADR-0002](ADR-0002-actor-isolated-system-services.md)), `@MainActor` isolation, `@Observable` ([ADR-0003](ADR-0003-observable-state-model.md)), and `Sendable` snapshots crossing isolation boundaries. The architecture's data-race-freedom claims are only true if the compiler enforces them.

## Problem

What language version, concurrency-checking level, and deployment target does the project build against, and how is the current project-file drift reconciled?

## Alternatives considered

1. **Stay on Swift 5 with minimal concurrency checking.** No migration work now, but the architecture's core safety claim (data races eliminated by construction) becomes unverified, and the gap compounds with every actor added.
2. **Swift 6 with `minimal`/`targeted` checking.** A partial step; defers the hard cases and leaves gaps the design assumes are closed.
3. **Swift 6 language mode with complete concurrency checking and a macOS 15 deployment target.** Matches the constitution and the code already written; surfaces every isolation issue at compile time.

## Decision

The project builds in **Swift 6 language mode with `SWIFT_STRICT_CONCURRENCY = complete`**, deployment target **macOS 15**, Apple Silicon first, on Xcode 16. The Xcode project settings are corrected to match (`SWIFT_VERSION = 6.0`, raised deployment target, strict concurrency complete) as the reconciling change, and this reconciliation is logged in the Notion Decision Log. New code assumes these settings; back-deployment shims are not added for macOS < 15. Decided by the founding engineering team.

## Trade-offs

Complete concurrency checking is the strictest setting and will reject patterns that "worked" under looser modes, costing migration effort whenever non-isolated shared state appears. macOS 15 excludes users on older systems. We accept both: the project is pre-release with no legacy user base, the architecture is built around strict isolation already, and paying the strictness now is far cheaper than retrofitting safety onto a grown codebase.

## Consequences

- The project file is updated in a single reconciling change; CI builds with these settings so drift cannot silently return (see [GovernanceAuditReport](../Engineering/GovernanceAuditReport.md) and [EngineeringReadinessAssessment](../Engineering/EngineeringReadinessAssessment.md)).
- All shared state crossing isolation is `Sendable` or actor-isolated; `@unchecked Sendable` requires a written justification in review.
- APIs newer than macOS 15 are used directly; no availability fallbacks below the baseline.
- This ADR is the canonical record; the `swift-concurrency` discipline applies to every migration question that arises.

## References

1. Apple, "Migrating to Swift 6." https://www.swift.org/migration/documentation/migrationguide/
2. Apple, "Swift compiler — strict concurrency checking." https://developer.apple.com/documentation/swift/adoptingswift6
