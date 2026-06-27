---
title: ADR-0014 Direct-manipulation widget interaction model
status: Accepted
owner: UI/UX
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [../UX/InteractionModel.md, ../UX/WidgetUX.md, ../Architecture/DesktopEngine.md, ../Research/DesktopCustomizationUXResearch.md, ADR-0001-appkit-window-swiftui-content.md]
---

# ADR-0014: Direct-manipulation widget interaction model

## Status

Accepted — 2026-06-27.

## Context

A user arranges widgets on the Desktop Frame surface. How they do so defines the product's feel. The codebase already supports grid snapping for positions and sizes ([CGPoint/CGSize extensions](../../desktop-frame/Core/Extensions/CGPoint+Extensions.swift)) on the 8-pt grid (`AppConstants.Widget.snapGrid`). Prior-art research found that competing tools gate customisation behind config files and scripting, which is their biggest adoption barrier, and that users already hold a "objects arranged on my desktop" mental model ([DesktopCustomizationUXResearch](../Research/DesktopCustomizationUXResearch.md), findings 1 and 3). The product principle "configurable without code" depends on the answer ([DesignPhilosophy](../Design/DesignPhilosophy.md)).

## Problem

What interaction model should govern arranging and configuring widgets — direct manipulation on the surface, or an indirect (forms/config) editor?

## Alternatives considered

1. **Indirect / forms-based editor.** A user picks position and size from fields or a separate layout editor. Precise and easy to make accessible, but slow, unintuitive, breaks the "it's my desktop" model, and echoes the config-driven tools users dislike. Rejected as the primary model (kept as a complement for precision).
2. **Config-file / scripting.** Maximum power for authors; fails "configurable without code" and the adoption evidence. Rejected for end users (authoring is a separate, advanced path).
3. **Direct manipulation first (chosen).** Move by dragging, resize by edges/handles, snap to the grid, see results instantly; every manipulation undoable; a forms-based inspector complements it for precise values and properties.

## Decision

Adopt a **direct-manipulation-first interaction model** ([InteractionModel](../UX/InteractionModel.md), [WidgetUX](../UX/WidgetUX.md)). Decided by UI/UX with the Window-System and Desktop-Engine owners. Widgets are moved, resized, selected, grouped, and arranged by direct manipulation on the surface, snapping to the 8-pt grid and settling with the standard spring; every manipulation is undoable; affordances appear on hover/selection/edit-mode and recede at rest. A forms-based **inspector** complements direct manipulation for exact values and non-spatial properties, and **full keyboard equivalents** exist for every manipulation so the model is accessible, not pointer-only ([AccessibilityDesign](../Design/AccessibilityDesign.md)). Input routing across the SwiftUI/AppKit seam is owned by the Desktop Engine and Window System ([ADR-0001](ADR-0001-appkit-window-swiftui-content.md)).

## Trade-offs

Direct manipulation costs significantly more engineering than a forms editor: hit-testing across the widget layer, snapping and guides, drag/resize at the display refresh rate, undo coalescing, and a parallel keyboard model for accessibility. Free-form placement also permits messier layouts than fixed slots. We accept these for the intuitive, no-code, "it's my desktop" feel that is the core of the product and the category's main unmet need.

## Consequences

- The Desktop Engine must route input precisely across the SwiftUI/AppKit seam (a known Sprint-1 risk — per-region click-through) ([EngineeringReadinessAssessment](../Engineering/EngineeringReadinessAssessment.md)).
- Every manipulation needs an undoable command and a keyboard equivalent ([InteractionModel](../UX/InteractionModel.md)).
- The Widget Container owns selection/resize/drag chrome so all widgets get it uniformly ([Surfaces](../Components/Surfaces.md)).
- Snapping, clamping, and persistence build on the existing grid extensions and layout persistence ([ADR-0008](ADR-0008-persistence-strategy.md), [ADR-0009](ADR-0009-per-display-independent-layouts.md)).

## References

1. [InteractionModel](../UX/InteractionModel.md) · [WidgetUX](../UX/WidgetUX.md) · [DesktopEngine](../Architecture/DesktopEngine.md) · [DesktopCustomizationUXResearch](../Research/DesktopCustomizationUXResearch.md).
2. Apple, "HIG — Inputs / Pointing devices." https://developer.apple.com/design/human-interface-guidelines/
