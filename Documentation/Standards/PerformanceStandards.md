---
title: Performance standards
status: Active
owner: Performance
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../Processes/QualityGates.md, ../../.agents/PERFORMANCE_AGENT.md, ../Templates/PerformanceReport.md]
---

# Performance standards

The performance budget and how it is enforced. The budget is a release gate, not an aspiration, because an always-on desktop layer that makes the Mac feel slow has failed regardless of how it looks.

## The budget

| Metric | Target |
|---|---|
| Idle CPU | under 0.5% per core |
| Memory (resident) | under 80 MB |
| Widget render | under 8 ms on 120 Hz displays |
| Launch to ready | under 500 ms |
| Per-service poll overhead | under 0.1% CPU |
| Live wallpaper | negligible battery cost, via hardware decode |

These targets are baselined on Apple Silicon and re-verified per major release.

## Rules

- Measure, never estimate. A performance claim without Instruments data does not pass the gate.
- Live wallpaper and video use hardware decode (AVFoundation, VideoToolbox). Software decode in the hot path is forbidden.
- One CATransaction per frame; no per-widget layout passes.
- No synchronous work over roughly one millisecond on the main thread.
- System metrics are polled off the main thread by `actor` services.

## Enforcement

A change in a hot path or the rendering pipeline attaches a [performance report](../Templates/PerformanceReport.md) with before-and-after numbers and a pass or fail per metric. A change that regresses the budget does not ship until fixed. The Performance agent owns the gate in [QualityGates.md](../Processes/QualityGates.md).

## Profiling

Use the Instruments Time Profiler, Core Animation, and Metal templates, on the supported hardware and display matrix, with a reproducible scenario. Record the setup so the measurement can be repeated.

## Common regressions to watch

- Software video decode creeping in and spinning the fans.
- Overdraw from stacked opaque layers.
- A widget update path that triggers layout for every widget instead of coalescing.
- Polling that drifts onto the main thread.
