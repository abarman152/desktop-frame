---
title: ADR-0003 @Observable for UI-facing state
status: Accepted
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-12-27
related: [ADR-0005-initializer-dependency-injection.md, ../Architecture/DataFlow.md]
---

# ADR-0003: `@Observable` for UI-facing state

## Status

Accepted — 2026-06-27. Back-fills a decision made during scaffolding.

## Context

Desktop Frame's UI-facing state (configuration, widget layout, theme, monitor map) drives a SwiftUI tree that is always on screen. Unnecessary view invalidation on an always-on layer is a direct performance cost. `AppConfiguration` is already written as `@MainActor @Observable`. The app targets macOS 15, so the Observation framework (Swift 5.9+, `@Observable`) is fully available with no back-deployment concern.

## Problem

Which observation mechanism do UI-facing state types use, given an always-on render surface where over-invalidation is a measurable cost?

## Alternatives considered

1. **`ObservableObject` + `@Published`.** Mature and familiar, but invalidates every observing view when *any* `@Published` property changes, regardless of which property a view reads. Coarse-grained; wasteful for a persistent layer.
2. **`@Observable` macro (Observation framework).** Tracks reads per property; a view re-renders only when a property it actually read changes. Finer-grained invalidation, less boilerplate, integrates with `@Environment` and `@Bindable`.
3. **Manual `objectWillChange` / hand-rolled diffing.** Maximum control, maximum maintenance burden and bug surface. Not justified.

## Decision

All UI-facing observable state uses the `@Observable` macro. `ObservableObject` is not used for new state. State types are `@MainActor`-isolated where they feed SwiftUI. Decided by the founding engineering team.

## Trade-offs

`@Observable` ties us to the Observation framework's behaviour and to macOS 14+ (already inside our macOS 15 baseline). We give up `ObservableObject`'s ubiquity in older tutorials in exchange for property-level invalidation that matters for an always-on surface.

## Consequences

- New state types are `@Observable`; reviews reject `ObservableObject` in UI-facing code without a recorded exception.
- Views depend on `@Observable` models via the environment or initializer injection (see [ADR-0005](ADR-0005-initializer-dependency-injection.md)), not singletons reached inside `body`.
- Invalidation scope is a [performance](../Standards/PerformanceStandards.md) concern; the `swiftui-performance` discipline applies when a view re-renders more than its inputs justify.

## References

1. Apple, "Observation." https://developer.apple.com/documentation/observation
2. Apple, "Managing model data in your app." https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app
