---
title: Swift style guide
status: Active
owner: Principal Engineer
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [NamingConventions.md, ../../CLAUDE.md, PerformanceStandards.md]
---

# Swift style guide

The canonical Swift style for Desktop Frame. This supersedes the earlier `Documentation/CodingStandards.md`, which migrates here. The architecture principles that motivate these rules are in [/CLAUDE.md](../../CLAUDE.md); naming is in [NamingConventions.md](NamingConventions.md).

## Language and concurrency

- Swift 6 with strict concurrency complete. Warnings are errors.
- System-data providers are `actor` types. UI-facing coordinators are `@MainActor`. Views are implicitly `@MainActor`.
- Types crossing an actor boundary conform to `Sendable`. Value types are preferred for this reason.
- No `DispatchQueue.main.async`. Use `@MainActor` and `await`.
- No `nonisolated(unsafe)` without a written, reviewed justification.

## State

- Use the `@Observable` macro, never `ObservableObject`.
- Prefer `let` over `var`. Prefer value types over reference types.
- Keep state out of leaf views; push it to a view model or manager.

## Safety

- No force unwrap or force try without a documented invariant explaining why it cannot fail.
- No silent error swallowing. Handle, propagate, or log with intent.
- No implicitly unwrapped optionals except where a framework requires them.

## Structure

- One primary type per file. Conformances may be separate extensions, one protocol per extension.
- `// MARK: -` sections in a consistent order: properties, init, public interface, private helpers, then conformances.
- Files stay focused; a file that does several unrelated things is split.
- No magic numbers or strings. Use `AppConstants`.

## Documentation

- `///` doc comments on every public and internal declaration, explaining why where the code does not already say it.
- No committed `TODO`. Open an issue.

## Modern idioms

- Prefer `if`/`switch` expressions, `guard` for early exit, and the modern collection APIs (`count(where:)`, `contains(where:)`).
- Use `FormatStyle` for formatting values rather than legacy formatters.
- Follow the project's Swift concurrency and SwiftUI skills for current patterns.

## Example

```swift
/// Polls CPU load off the main thread and publishes samples.
actor CPUService {
    private let clock: any Clock<Duration>

    init(clock: any Clock<Duration> = ContinuousClock()) {
        self.clock = clock
    }

    func sample() async throws -> CPUSample { /* ... */ }
}
```

## Completion and review

A change meets this guide when it builds clean under strict concurrency, follows the structure and safety rules, and documents its declarations. The full per-change gate is the review checklist in [/CLAUDE.md](../../CLAUDE.md) and [ReviewChecklist.md](ReviewChecklist.md).
