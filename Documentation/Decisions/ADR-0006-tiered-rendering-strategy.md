---
title: ADR-0006 Tiered rendering strategy
status: Accepted
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-12-27
related: [../Architecture/RenderingEngine.md, ../Architecture/WallpaperEngine.md, ../Standards/PerformanceStandards.md]
---

# ADR-0006: Tiered rendering strategy

## Status

Accepted — 2026-06-27.

## Context

Desktop Frame must render content ranging from a static text clock to a 4K video wallpaper to an interactive Metal shader, on an always-on surface bound by a strict [performance budget](../Standards/PerformanceStandards.md) (idle CPU < 0.5%/core, widget render < 8 ms at 120 Hz, live wallpaper via hardware decode). No single rendering technology is right for all of that: SwiftUI is the most productive for widgets but the wrong tool for a per-pixel shader; Metal is necessary for shaders but ruinous boilerplate for a label. `AppConfiguration.enableHardwareAcceleration` already anticipates a graduated approach.

## Problem

Which rendering technology does each kind of content use, and how does the system choose, so that we get both developer productivity and the GPU control the budget demands?

## Alternatives considered

1. **SwiftUI for everything.** Most productive, but cannot express custom shaders efficiently and gives up frame-level control needed for video and dynamic wallpapers.
2. **Metal for everything.** Maximum control and performance, but enormous cost to build ordinary widgets and a steep wall for plugin authors.
3. **A fixed two-way split (SwiftUI widgets, Metal wallpaper).** Simple, but leaves no home for content between the two — animated widgets, particle effects — and forces premature escalation to Metal.
4. **Three explicit tiers with defined escalation criteria.** Content starts at the cheapest tier that suffices and escalates only when it must.

## Decision

Adopt three rendering tiers, choosing the lowest that meets the content's needs:

- **Tier 1 — SwiftUI.** Default for all widgets and chrome. Declarative, accessible, themeable.
- **Tier 2 — Core Animation / `CALayer`.** For continuous animation, transitions, and compositing where SwiftUI invalidation would be wasteful; reached via the AppKit bridge.
- **Tier 3 — Metal (`MTKView` / `CAMetalLayer`).** For shader wallpapers, GPU effects, and per-pixel content. Video wallpaper uses `AVPlayerLayer` with hardware decode (VideoToolbox), not software blitting.

Escalation is explicit and justified, never default. A widget renders in Tier 1 unless a measured need (frame rate, effect, GPU offload) moves it up. Decided by the founding engineering team.

## Trade-offs

Three tiers mean three rendering code paths to maintain and a bridging seam between them. We accept that to avoid both the productivity tax of all-Metal and the capability ceiling of all-SwiftUI. The escalation rule keeps most content in the cheap, accessible tier.

## Consequences

- The plugin SDK exposes Tier 1 to all authors and Tier 3 under a capability/permission for trusted shader widgets; see [PluginSDK](../Architecture/PluginSDK.md).
- Every tier obeys **one `CATransaction` per frame** and the [performance budget](../Standards/PerformanceStandards.md); a tier escalation that regresses the budget does not ship.
- Accessibility is native in Tier 1; Tier 2/3 content must supply an accessible representation (see [AccessibilityStandards](../Standards/AccessibilityStandards.md)).
- The fallback path (GPU unavailable, low-power mode) degrades Tier 3 → a static representation; defined in [RenderingEngine](../Architecture/RenderingEngine.md).

## References

1. Apple, "Core Animation." https://developer.apple.com/documentation/quartzcore
2. Apple, "Metal." https://developer.apple.com/documentation/metal
3. Apple, "VideoToolbox." https://developer.apple.com/documentation/videotoolbox
