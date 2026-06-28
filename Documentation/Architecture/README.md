---
title: Architecture index
status: Active
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [Architecture.md, ../README.md, ../Decisions/README.md]
---

# Architecture index

The map of Desktop Frame's engineering blueprint. Start at [System architecture](Architecture.md) for the whole-system view; each subsystem below has its own document. Every significant decision behind these designs is an [ADR](../Decisions/README.md); the documents link the ADRs that govern them.

## Read in this order

1. [System architecture](Architecture.md) — layers, boundaries, concurrency model, the consolidated invariant list.
2. [Clean architecture](CleanArchitecture.md) — the conceptual layers and where each type belongs.
3. [Data flow](DataFlow.md) — state ownership, the reactive and command paths, caching, persistence.
4. [Dependency injection](DependencyInjection.md) — composition root, lifetimes, testing seam.

## Subsystems

| Document | Owns | Key ADRs |
|---|---|---|
| [Window system](WindowSystem.md) | `NSWindow` subclasses, levels, Spaces/Mission Control/Stage Manager, displays, focus | [0001](../Decisions/ADR-0001-appkit-window-swiftui-content.md), [0009](../Decisions/ADR-0009-per-display-independent-layouts.md) |
| [Desktop engine](DesktopEngine.md) | The canvas, interaction modes, Finder compatibility, input routing, layout | [0001](../Decisions/ADR-0001-appkit-window-swiftui-content.md) |
| [Widget engine](WidgetEngine.md) | Widget lifecycle, registration, config/versioning, update loop, isolation | [0007](../Decisions/ADR-0007-out-of-process-plugin-isolation.md), [0010](../Decisions/ADR-0010-widget-configuration-schema-versioning.md) |
| [Rendering engine](RenderingEngine.md) | The tiered pipeline, scheduler, animation, GPU budget, fallback | [0006](../Decisions/ADR-0006-tiered-rendering-strategy.md) |
| [Wallpaper engine](WallpaperEngine.md) | Static/dynamic/video/shader/interactive wallpaper, power-aware lifecycle | [0006](../Decisions/ADR-0006-tiered-rendering-strategy.md), [0009](../Decisions/ADR-0009-per-display-independent-layouts.md) |
| [Multi-monitor](MultiMonitorArchitecture.md) | Display identity, reconcile, profiles, reflow, hot-plug | [0009](../Decisions/ADR-0009-per-display-independent-layouts.md) |
| [Theme system](ThemeSystem.md) | Design tokens, appearance, inheritance, custom themes | [0003](../Decisions/ADR-0003-observable-state-model.md) |
| [Plugin SDK](PluginSDK.md) | The third-party boundary: lifecycle, API, sandbox, versioning, marketplace | [0007](../Decisions/ADR-0007-out-of-process-plugin-isolation.md), [0010](../Decisions/ADR-0010-widget-configuration-schema-versioning.md) |
| [System services](SystemServices.md) | actor data providers, polling/sharing, permissions, logging/diagnostics/telemetry | [0002](../Decisions/ADR-0002-actor-isolated-system-services.md) |

## Related

- [Decisions](../Decisions/README.md) — the ADR record (ADR-0001…0011 establish the architecture above).
- [Research/MacOSPlatformResearch](../Research/MacOSPlatformResearch.md) — the platform-behaviour evidence the window and rendering designs rest on.
- [Engineering/EngineeringReadinessAssessment](../Engineering/EngineeringReadinessAssessment.md) — the readiness review, risks, and recommended Sprint 1.
- [Standards](../Standards) — performance, security, accessibility budgets these designs honour.
