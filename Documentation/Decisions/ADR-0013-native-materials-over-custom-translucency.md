---
title: ADR-0013 Native materials over custom translucency
status: Accepted
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [../Design/MaterialsAndElevation.md, ../Architecture/ThemeSystem.md, ../Architecture/RenderingEngine.md, ../Standards/AccessibilityStandards.md, ADR-0006-tiered-rendering-strategy.md]
---

# ADR-0013: Native materials over custom translucency

## Status

Accepted — 2026-06-27.

## Context

Desktop Frame's surfaces (widgets, panels, the Dashboard) are translucent so the user's wallpaper shows through, which is core to "defer to the user's content" ([DesignPhilosophy](../Design/DesignPhilosophy.md)). Translucency can be achieved with the system's vibrancy materials (`NSVisualEffectView`, SwiftUI `Material`, and the platform's Liquid Glass direction) or with a hand-rolled blur (custom Core Image / Metal blur of the backdrop). Surfaces run continuously on the desktop, so their cost and their appearance under accessibility settings matter ([RenderingEngine](../Architecture/RenderingEngine.md), [AccessibilityStandards](../Standards/AccessibilityStandards.md)). The existing semantic colours already layer a near-opaque tint over the system window background ([Color+Extensions.swift](../../desktop-frame/Core/Extensions/Color+Extensions.swift)).

## Problem

Should Desktop Frame build its translucent surfaces from native system materials, or from a custom blur implementation?

## Alternatives considered

1. **Custom blur (hand-rolled).** Full control over the exact look; can match a bespoke brand. But: expensive (a continuous backdrop blur per surface), must re-implement Reduce Transparency and Increase Contrast fallbacks, won't match the rest of macOS, and won't track the platform's evolving Liquid Glass look. Rejected.
2. **Native materials (chosen).** `NSVisualEffectView`/SwiftUI `Material`, tokenised as `glass`/`blur`/`opaque`. Matches macOS exactly, inherits vibrancy tuning and accessibility fallbacks for free, is GPU-optimised by the system, and adopts platform changes automatically. Less control over the precise look.
3. **Opaque surfaces only.** Cheapest and simplest, but discards the translucency that defines the product's look and its deference to wallpaper. Rejected.

## Decision

Use **native system materials** for all translucent surfaces, exposed as the `material.glass | blur | opaque` tokens ([MaterialsAndElevation](../Design/MaterialsAndElevation.md), [ADR-0012](ADR-0012-semantic-design-token-architecture.md)). Decided by the Product Designer with the Metal/Performance engineers. No surface hand-rolls a backdrop blur. Translucency is the material's job; a near-opaque tinted colour layer sits on top for legibility. Under Reduce Transparency the material resolves to `opaque`; under Increase Contrast borders strengthen ([AccessibilityDesign](../Design/AccessibilityDesign.md)). GPU wallpaper (video/shader) is a separate concern under the tiered rendering strategy ([ADR-0006](ADR-0006-tiered-rendering-strategy.md)).

## Trade-offs

We give up precise control over the exact translucency look and accept a dependency on platform material behaviour changing under us (including the Liquid Glass transition). In return we get an exact native match, free accessibility fallbacks, lower and system-optimised GPU cost, and zero-maintenance adoption of future platform looks.

## Consequences

- The Glass Panel component wraps `NSVisualEffectView` via the AppKit bridge; no other surface implements blur ([Surfaces](../Components/Surfaces.md), [EngineeringHandoff](../Design/EngineeringHandoff.md)).
- Material tokens carry the Reduce-Transparency/Increase-Contrast fallbacks centrally; widgets get them for free.
- The performance budget forbids stacking multiple vibrancy layers; nested blur is a perf bug ([MaterialsAndElevation](../Design/MaterialsAndElevation.md)).
- When Liquid Glass APIs are available on target OS versions, `glass`/`blur` map onto them with no widget changes.

## References

1. [MaterialsAndElevation](../Design/MaterialsAndElevation.md) · [ThemeSystem](../Architecture/ThemeSystem.md) · [ADR-0006](ADR-0006-tiered-rendering-strategy.md).
2. Apple, "NSVisualEffectView / Materials." https://developer.apple.com/documentation/appkit/nsvisualeffectview
3. Apple, "HIG — Materials." https://developer.apple.com/design/human-interface-guidelines/materials
