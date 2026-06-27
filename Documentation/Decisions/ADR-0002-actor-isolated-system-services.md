---
title: ADR-0002 Actor-isolated system services
status: Accepted
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-12-27
related: [ADR-0011-swift6-strict-concurrency-baseline.md, ../Architecture/SystemServices.md, ../Architecture/DataFlow.md]
---

# ADR-0002: Actor-isolated system services

## Status

Accepted — 2026-06-27. Back-fills a decision made during scaffolding.

## Context

Desktop Frame continuously reads system metrics — CPU, memory, GPU, battery, storage, network — and external data such as Calendar and Reminders. These reads call blocking or latency-bearing APIs: `host_statistics64`, `vm_statistics64`, IOKit power sources, `FileManager` volume attributes, `NWPathMonitor`, EventKit fetches. Running any of them on the main thread would stall the render loop and breach the [performance budget](../Standards/PerformanceStandards.md) (idle CPU < 0.5%/core, no main-thread work over ~1 ms). The scaffolding already reserves per-service refresh intervals (`AppConstants.RefreshInterval`) and OSLog categories (`AppLogger.services`).

The project targets Swift 6 strict concurrency, where shared mutable state crossing isolation boundaries must be provably race-free.

## Problem

How do we poll system data off the main thread, race-free, and deliver it to `@MainActor` UI without locks or manual thread management?

## Alternatives considered

1. **GCD queues + locks.** Familiar, but correctness depends on programmer discipline; Swift 6 cannot verify it, and it is the classic source of metric-polling data races.
2. **`@MainActor` everything, work hopped via `Task.detached`.** Simple isolation story but pushes parsing and aggregation back onto the main actor or scatters detached tasks with no ownership.
3. **One `actor` per service.** Each service owns its polling state and cadence; the compiler guarantees isolation; results cross to `@MainActor` via `async` calls or `AsyncStream`. Idiomatic Swift 6.
4. **Combine publishers on background schedulers.** Works, but Combine is in maintenance, mixes poorly with `async/await`, and adds a paradigm the rest of the system avoids.

## Decision

Each system-data provider is a Swift `actor` (`CPUService`, `MemoryService`, `NetworkService`, `BatteryService`, `StorageService`, `CalendarService`, `ReminderService`, …) behind a protocol. Services own their polling timers and caches in actor-isolated state, emit `Sendable` value snapshots, and publish to `@MainActor` managers via `AsyncStream`. No service touches AppKit or SwiftUI. Decided by the founding engineering team.

## Trade-offs

Actor hops add `await` suspension points and a small scheduling cost versus a direct synchronous read. We accept that for compiler-proven freedom from data races and a clean off-main polling story. Where a hop per sample would be wasteful (high-frequency metrics), a service batches and coalesces before publishing.

## Consequences

- `Core/Services/` contains only `actor` types and their protocols; managers in `Core/Managers/` are `@MainActor` and consume them.
- All data crossing the service→manager boundary is `Sendable`; see [Models](../Standards/FolderStructure.md) and [DataFlow](../Architecture/DataFlow.md).
- Services are unit-tested with injected clocks (no wall-clock sleeps); see [TestingStrategy](../Development/TestingStrategy.md).
- The invariant **no service performs UI work or blocks the main thread** is owned here.

## References

1. Apple, "Actors." https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Actors
2. Apple, "AsyncStream." https://developer.apple.com/documentation/swift/asyncstream
