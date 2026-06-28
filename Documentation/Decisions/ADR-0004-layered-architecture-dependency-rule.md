---
title: ADR-0004 Layered architecture and the downward dependency rule
status: Accepted
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-12-27
related: [../Architecture/Architecture.md, ../Architecture/CleanArchitecture.md, ../Standards/FolderStructure.md]
---

# ADR-0004: Layered architecture and the downward dependency rule

## Status

Accepted — 2026-06-27. Formalises the structure asserted by the constitution and `Architecture.md`.

## Context

The constitution and `Documentation/Standards/FolderStructure.md` already assert four layers (App → Features → Core → Foundation) and the rule that features never import features. That rule is load-bearing for a system intended to grow a plugin SDK and a marketplace, but it lived only as prose. A dependency rule that is not recorded as a decision gets eroded the first time a deadline makes a sideways import convenient.

## Problem

What is the dependency rule between layers and modules, and how is it enforced, so the architecture stays acyclic as the surface area grows?

## Alternatives considered

1. **No enforced layering; pragmatic imports.** Fastest early, but accrues cycles and turns the codebase into a graph no one can reason about. The failure mode this project most needs to avoid.
2. **Strict layering within a single module, enforced by review.** Cheap, no build changes, but relies on human vigilance.
3. **Layering enforced by separate Swift packages/targets**, so an illegal import fails to compile. Strongest guarantee; costs build-graph complexity up front.
4. **Layering by convention now, hardened into packages as the SDK boundary forms.** Start with review enforcement and folder discipline; extract `Core` and the plugin API into packages when the public boundary is real.

## Decision

Adopt option 4. Dependencies flow strictly downward: App depends on Features and Core; Features depend on Core and Foundation; Core depends on Foundation; Foundation depends on nothing internal. **Features never import other features** — shared behaviour moves down into Core. Enforced by review and `FolderStructure.md` now; the `Core` services boundary and the plugin API graduate to their own Swift packages when the plugin SDK is built, making the boundary a compiler guarantee. Decided by the founding engineering team.

## Trade-offs

Convention-based enforcement can be violated until the package split lands; we accept that interim risk to avoid paying build-graph complexity before the boundaries have stabilised. The cost of the eventual extraction is bounded because the folder structure already mirrors the intended package structure.

## Consequences

- Cross-feature behaviour is refactored downward into Core, never imported sideways. This is the named invariant **the feature graph is acyclic**.
- The [DependencyInjection](../Architecture/DependencyInjection.md) approach must let App compose features without features knowing each other.
- A future ADR will record the package extraction when the plugin SDK boundary is drawn; this ADR is its precursor.
- CI should add an import-graph check (see [EngineeringReadinessAssessment](../Engineering/EngineeringReadinessAssessment.md) technical debt).

## References

1. Robert C. Martin, "Clean Architecture" (dependency rule). 2017.
