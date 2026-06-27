---
title: ADR-0005 Initializer-based dependency injection
status: Accepted
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-12-27
related: [ADR-0004-layered-architecture-dependency-rule.md, ../Architecture/DependencyInjection.md]
---

# ADR-0005: Initializer-based dependency injection

## Status

Accepted — 2026-06-27. Back-fills the composition approach asserted by `Architecture.md`.

## Context

`Architecture.md` already states there is no global service locator and that `AppDelegate` composes the object graph on launch. The system is protocol-first (every engine and service has a protocol), which only pays off if concrete implementations are *injected* rather than reached through globals. The one existing singleton, `AppConfiguration.shared`, is user-settings state, not a service dependency.

## Problem

How are dependencies supplied to the types that need them, such that every type is testable in isolation and the dependency graph is explicit?

## Alternatives considered

1. **Global singletons / service locator.** Trivial to call from anywhere, but hides the dependency graph, makes substitution for tests hard, and invites the very cross-layer reaching [ADR-0004](ADR-0004-layered-architecture-dependency-rule.md) forbids.
2. **A DI container/framework.** Centralises wiring, but adds a dependency, runtime resolution failures, and indirection that obscures what depends on what in a graph this size.
3. **Initializer injection, composed at the root.** Each type receives its collaborators (as protocols) through `init`. `AppDelegate` is the composition root. Dependencies are visible in the signature and trivially mockable.
4. **SwiftUI `@Environment` for everything.** Idiomatic for view-facing values, but unsuitable for non-view services and engines, and it makes dependencies implicit at the read site.

## Decision

Use initializer injection with `AppDelegate` as the single composition root. Engines, managers, and services declare their dependencies as protocol-typed `init` parameters. The SwiftUI layer receives `@Observable` models through `@Environment`/`@Bindable` (the view-appropriate form of the same idea), but those models are themselves composed by the root, not self-instantiated. `AppConfiguration.shared` remains the one sanctioned singleton because it is global user state, not an injectable collaborator. Decided by the founding engineering team.

## Trade-offs

The composition root grows as the system grows, and wiring is manual. We accept a larger root over hidden globals because the root is one auditable place where the whole graph is visible, and manual wiring needs no framework and fails at compile time, not at runtime.

## Consequences

- Every engine/manager/service is constructible with mock dependencies in a test; see [TestingStrategy](../Development/TestingStrategy.md).
- The composition root is itself a reviewed artifact; a new subsystem is wired there.
- View models reach services only through injected `@Observable` state, never `Service.shared`.
- If the root becomes unwieldy, it is decomposed into per-subsystem assembler functions — still initializer injection, just grouped — before any container is considered.

## References

1. Mark Seemann, "Dependency Injection Principles, Practices, and Patterns." 2019.
2. Apple, "Environment." https://developer.apple.com/documentation/swiftui/environment
