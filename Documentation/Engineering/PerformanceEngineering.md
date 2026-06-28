---
title: Performance engineering
status: Active
owner: Performance
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [../Standards/PerformanceStandards.md, ../Architecture/RenderingEngine.md, ../Architecture/SystemServices.md, ../Templates/PerformanceReport.md]
---

# Performance engineering

The engineering practice behind the performance budget: how the budget in [PerformanceStandards](../Standards/PerformanceStandards.md) is allocated across subsystems, measured, and defended. The budget itself (the numbers and the release-gate rule) is canonical in the standard; this document does not restate it — it explains how the architecture meets it and how regressions are caught.

## Purpose and scope

In scope: the per-subsystem budget allocation, the measurement methodology and scenarios, the design tactics that keep the surface cheap, and the regression-watch list. Out of scope: the budget values and the gate policy ([PerformanceStandards](../Standards/PerformanceStandards.md)).

## Context

Desktop Frame runs forever in the background, so its cost is paid every minute of every day on the user's machine. The product principle is explicit: "an always-on desktop layer that makes the Mac feel slow has failed regardless of how it looks." Performance here is therefore not an optimisation phase but an architectural constraint that already shaped the actor split, the rendering tiers, and the widget update loop.

## Design

### Budget allocation

The system budget ([PerformanceStandards](../Standards/PerformanceStandards.md)) is allocated to subsystems so each owner knows their share:

| Budget line | Standard target | Primary owner | Design tactic |
|---|---|---|---|
| Idle CPU | < 0.5% / core | all | suspend unseen work; coalesce updates; off-main polling |
| Per-service poll | < 0.1% CPU | [SystemServices](../Architecture/SystemServices.md) | shared snapshots; cadence back-off; suspend with no subscribers |
| Widget render | < 8 ms @120 Hz | [WidgetEngine](../Architecture/WidgetEngine.md) / [RenderingEngine](../Architecture/RenderingEngine.md) | Tier-1 default; one transaction/frame; property-level invalidation |
| Memory (resident) | < 80 MB | all | disposable caches; no retained decoded frames when paused |
| Launch to ready | < 500 ms | [App](../Architecture/Architecture.md) | lazy service start; defer non-critical work past first frame |
| Live wallpaper energy | negligible | [WallpaperEngine](../Architecture/WallpaperEngine.md) | hardware decode; pause when unseen; throttle on power/thermal |

### The four design tactics

The budget is met by construction, not by late tuning, through four tactics already in the architecture:

1. **Do nothing when nothing is seen.** Suspended widgets, paused wallpaper, and subscriber-less services do zero work ([WidgetEngine](../Architecture/WidgetEngine.md), [WallpaperEngine](../Architecture/WallpaperEngine.md), [SystemServices](../Architecture/SystemServices.md)).
2. **Coalesce.** One transaction per frame, batched widget updates capped by `maxConcurrentWidgetUpdates`, shared system snapshots ([RenderingEngine](../Architecture/RenderingEngine.md)).
3. **Invalidate narrowly.** `@Observable` property-level tracking means a metric tick redraws only its readers ([ADR-0003](../Decisions/ADR-0003-observable-state-model.md)).
4. **Offload and hardware-decode.** Polling off the main thread (actors); video/shaders on the GPU with VideoToolbox/Metal, never software decode ([ADR-0002](../Decisions/ADR-0002-actor-isolated-system-services.md), [ADR-0006](../Decisions/ADR-0006-tiered-rendering-strategy.md)).

### Measurement methodology

Measure, never estimate ([PerformanceStandards](../Standards/PerformanceStandards.md)). The standard scenarios, run on the supported Apple Silicon and display matrix:

- **Idle baseline** — surface with a representative widget set, no interaction, 10 minutes; sample CPU, memory, energy.
- **Active wallpaper** — each wallpaper kind (static/dynamic/video/shader), on AC and on battery, with thermal state logged.
- **Widget burst** — many widgets updating simultaneously; assert frame time and the coalescing cap hold.
- **Launch** — cold and warm launch to first-ready-frame.
- **Hot-plug** — display add/remove under load; assert no frame-time spike beyond budget.

Instruments templates: Time Profiler, Core Animation, Metal, Energy. Each measurement records its setup so it is reproducible; results attach to a [PerformanceReport](../Templates/PerformanceReport.md).

### Regression watch list

The named regressions to guard against ([PerformanceStandards](../Standards/PerformanceStandards.md)) plus their architectural tripwires:

- **Software decode creeping in** — fans spin; tripwire: any decode path not routed through VideoToolbox/AVFoundation.
- **Overdraw** — stacked opaque layers; tripwire: opaque layers above the wallpaper that could be merged.
- **Per-widget layout** — update path triggering layout for every widget; tripwire: a layout pass count > 1 per frame.
- **Polling drifting onto main** — tripwire: any `@MainActor`-isolated metric read.
- **Invalidation broadening** — a view re-rendering more than its inputs justify; tripwire: `swiftui-performance` body-count audit.

## Invariants

1. **Every budget line has a named owner** and a design tactic, not just a target.
2. **A hot-path or pipeline change is measured before and after** with Instruments ([PerformanceStandards](../Standards/PerformanceStandards.md)).
3. **A change that regresses the budget does not ship** until fixed ([QualityGates](../Processes/QualityGates.md)).

## Known limitations

- Energy figures vary across Apple Silicon generations; the budget is baselined per major release on the reference hardware, and per-chip variance is recorded rather than averaged away.
- Until CI runs a perf smoke test ([GovernanceAuditReport](GovernanceAuditReport.md)), regression detection relies on the per-change report discipline; automating a lightweight perf check is recommended in [EngineeringReadinessAssessment](EngineeringReadinessAssessment.md).

## Future evolution

A CI perf smoke test (launch time, idle CPU on a fixed widget set) turns the manual report discipline into an automated tripwire; the full Instruments scenarios remain a periodic and per-hot-path human measurement.

## References

1. [PerformanceStandards](../Standards/PerformanceStandards.md) · [PerformanceReport](../Templates/PerformanceReport.md) · [QualityGates](../Processes/QualityGates.md).
2. Apple, "Instruments." https://developer.apple.com/documentation/instruments
3. The `swiftui-performance` discipline for invalidation audits.

## Completion checklist
- [x] Budget allocated to subsystem owners.
- [x] Measurement scenarios and tools stated.
- [x] Design tactics and regression tripwires listed.
- [x] Invariants named; standard linked, not restated.

## Review checklist
- [ ] Allocations reconciled with subsystem docs.
- [ ] Scenarios runnable on the hardware matrix.
- [ ] Meets DocumentationStandards.
