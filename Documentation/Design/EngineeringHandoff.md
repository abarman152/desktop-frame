---
title: Engineering handoff
status: Active
owner: Staff SwiftUI Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [../Components/ComponentArchitecture.md, DesignTokens.md, MotionSystem.md, ../Architecture/CleanArchitecture.md, ../Standards/SwiftStyleGuide.md, ../Decisions/ADR-0001-appkit-window-swiftui-content.md]
---

# Engineering handoff

How the design system and component library become Swift: the SwiftUI/AppKit split, animation, performance, accessibility, testing, and dependency guidance per component family. It is the bridge between [Components](../Components/README.md) and the [architecture](../Architecture/README.md), and it defers to the existing engineering docs and skills rather than restating them. The handoff exists so an engineer implements a component without re-deriving the design intent.

## Purpose and scope

In scope: implementation guidance per family and the cross-cutting SwiftUI/AppKit, animation, performance, a11y, and testing rules. Out of scope: the component specs themselves ([Components](../Components/README.md)) and Swift style ([SwiftStyleGuide](../Standards/SwiftStyleGuide.md)).

## The SwiftUI / AppKit split

Default to **SwiftUI** for content and controls; reach for **AppKit** only where SwiftUI lacks the capability ([ADR-0001](../Decisions/ADR-0001-appkit-window-swiftui-content.md), `appkit-bridge` skill):

| Need | Use |
|---|---|
| Widget content, cards, controls, forms, galleries | SwiftUI |
| Translucent surfaces / vibrancy | `NSVisualEffectView` via `NSViewRepresentable` (the Glass Panel) |
| Floating/overlay windows (Dashboard, floating toolbar) | `NSPanel` / window configuration ([WindowSystem](../Architecture/WindowSystem.md)) |
| The desktop surface window & levels | AppKit `NSWindow` subclasses ([WindowSystem](../Architecture/WindowSystem.md)) |
| Global event monitoring, responder-chain integration | AppKit `NSEvent`, hosted via the bridge |
| Native menus | `NSMenu` / SwiftUI `Menu` |
| GPU wallpaper (video/shader) | Metal / Core Animation ([RenderingEngine](../Architecture/RenderingEngine.md)) |

Tokens reach SwiftUI via the environment ([ThemeSystem](../Architecture/ThemeSystem.md)); a Tier-3 (Metal) surface reads a token snapshot via the `themeDidChange` bridge ([DesignTokens](DesignTokens.md)).

## Cross-cutting guidance

- **Tokens, never literals.** Components read `theme.*` tokens; no hard-coded colours, sizes, or durations ([DesignTokens](DesignTokens.md)). Reuse `AppConstants` and the existing `Color`/`CGSize`/`CGPoint` extensions.
- **State & concurrency.** UI types are `@MainActor`; system data comes from `actor` services; state is `@Observable` ([ADR-0002](../Decisions/ADR-0002-actor-isolated-system-services.md), [ADR-0003](../Decisions/ADR-0003-observable-state-model.md), `swift-concurrency` skill). Strict concurrency is on ([ADR-0011](../Decisions/ADR-0011-swift6-strict-concurrency-baseline.md)).
- **Animation.** Animate transform/opacity with the motion tokens; respect Reduce Motion via `accessibilityReduceMotion`; never animate layout/blur/shadow on the hot path ([MotionSystem](MotionSystem.md), `swiftui-performance` skill).
- **Accessibility.** Labels/traits/values on every control; grouped widget elements; visible focus; `@ScaledMetric` for text-adjacent sizing ([AccessibilityDesign](AccessibilityDesign.md), `ios-accessibility` skill).
- **Performance.** Lazy lists/galleries; small `body`; stable identity; bounded sample buffers for charts; only-visible rendering ([swiftui-performance] guidance, [PerformanceStandards](../Standards/PerformanceStandards.md)).
- **Dependencies flow downward.** App → Features → Core; features never import features; shared components live in the library ([ADR-0004](../Decisions/ADR-0004-layered-architecture-dependency-rule.md), [CleanArchitecture](../Architecture/CleanArchitecture.md)).

## Per-family notes

| Family | SwiftUI/AppKit | Animation | Performance | A11y | Testing |
|---|---|---|---|---|---|
| [Surfaces](../Components/Surfaces.md) | Glass Panel = `NSVisualEffectView` bridge; canvas = `NSWindow`; cards = SwiftUI | Edit-mode & snap (spring) | One vibrancy layer; only-visible widgets | Grouped widget element; keyboard move/resize | Snapshot panels; integration test the surface window on real AppKit |
| [Controls](../Components/Controls.md) | SwiftUI; `NSMenu` for menus | `motion.fast` press/hover | Cheap; debounce search | Labels, traits, keyboard | Unit + snapshot per variant/state |
| [Navigation](../Components/Navigation.md) | SwiftUI; `NSPanel` floating toolbar; settings = SwiftUI scene | Pane switch `fast` | Static forms | Source-list & form semantics | Integration test settings navigation |
| [Overlays](../Components/Overlays.md) | System sheets/popovers/alerts where possible | System timings | On-demand build/teardown | Focus trap & restore | Test focus management |
| [DataAndCharts](../Components/DataAndCharts.md) | SwiftUI / Swift Charts | Calm value interpolation | Ring buffers; pause off-screen; honour `RefreshInterval` | "Audio chart" summaries | Mock-clock service tests; snapshot states |
| [Widgets](../Components/Widgets.md) | SwiftUI content; EventKit/services via actors | `fast` content updates | Service cadence, not per-frame | Grouped element; permission states | Mock services with injected clock |
| [StatesAndFeedback](../Components/StatesAndFeedback.md) | SwiftUI | Subtle shimmer; cross-fade | Cheap placeholders | Loading/error announced | Snapshot each state |
| [Marketplace](../Components/Marketplace.md) | SwiftUI; out-of-process plugin host | Hover lift; install progress | Lazy/virtualised gallery | Trust/status as text | Test permission display & install states |

## Testing recommendations

Services get unit tests with mocked clocks; managers/surfaces get integration tests on real AppKit ([TestingStrategy](../Development/TestingStrategy.md)). Each component gets a SwiftUI **preview gallery** (every variant × state) and **snapshot tests**, plus an accessibility audit (labels, focus, Dynamic Type, contrast) in CI where available. A bug fix adds a failing-then-passing test ([QualityGates](../Processes/QualityGates.md)).

## Dependencies

First-party frameworks only by default ([DependencyPolicy](../Standards/DependencyPolicy.md)): SwiftUI, AppKit, Swift Charts, Core Animation/Metal, EventKit, Network.framework, OSLog. No third-party UI frameworks; no Electron/Catalyst ([CLAUDE.md](../../CLAUDE.md) forbidden practices). Any new dependency goes through the dependency policy.

## Accessibility & performance gates

A component is not "done" until it passes the accessibility and performance gates ([QualityGates](../Processes/QualityGates.md)): VoiceOver/keyboard/Reduce-Motion/Reduce-Transparency/Dynamic-Type pass, and it holds the frame budget measured with Instruments ([swiftui-performance] `.trace` capture).

## Trade-offs

- Centralising guidance here risks drift from the component docs; mitigated by keeping it a *map* to the specs and skills, not a copy.
- Defaulting to first-party frameworks costs some convenience versus popular third-party UI libs; required for the native feel and longevity.

## Future evolution

A generated token API from `Constants.swift`, a shared preview/snapshot harness, and Code Connect-style mappings between the component specs and their SwiftUI implementations as the library is built ([ComponentArchitecture](../Components/ComponentArchitecture.md) future evolution).

## Open questions

- Whether to adopt Swift Charts for all graphs or a custom lightweight renderer for the always-on widgets, pending a perf spike ([DataAndCharts](../Components/DataAndCharts.md)).

## References

1. [ComponentArchitecture](../Components/ComponentArchitecture.md) · [CleanArchitecture](../Architecture/CleanArchitecture.md) · [ADR-0001](../Decisions/ADR-0001-appkit-window-swiftui-content.md) · skills: `swiftui-expert-skill`, `appkit-bridge`, `swift-concurrency`, `ios-accessibility`, `swiftui-performance`.
2. Apple, "SwiftUI / AppKit." https://developer.apple.com/documentation/swiftui

## Completion checklist
- [x] SwiftUI/AppKit split and cross-cutting rules stated.
- [x] Per-family implementation, perf, a11y, testing notes provided.
- [x] Dependency and quality-gate guidance included.

## Review checklist
- [ ] Reconciled with the architecture docs and skills as they evolve.
- [ ] Per-family notes verified against first built components.
- [ ] Meets DocumentationStandards.
