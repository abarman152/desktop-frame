---
title: Layout and spacing
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [DesignSystem.md, DesignTokens.md, ../UX/InteractionModel.md, ../Components/ComponentArchitecture.md]
---

# Layout and spacing

The geometry of Desktop Frame: a single 8-point grid that governs spacing, the widget snap grid, and panel layout, so everything aligns and nothing is placed by eye. Spacing is a small token scale, not arbitrary numbers, and the scale *is* the constants the code already ships ([Constants.swift](../../desktop-frame/Core/Utilities/Constants.swift)). This document owns the spacing scale, the grid, density, and responsive behaviour.

## Purpose and scope

In scope: the spacing scale, the 8-pt grid and widget snap grid, the layout grid for panels, density, and how layouts respond to window and display size. Out of scope: corner radius and elevation ([MaterialsAndElevation](MaterialsAndElevation.md)) and per-component measurements ([Components](../Components/README.md)).

## Design principles

- **One grid.** Everything aligns to an 8-point grid. The widget snap grid (`AppConstants.Widget.snapGrid = 8`) and the spacing scale are the same grid at different magnifications.
- **Spacing is a token.** Use `s`/`m`/`l`, never `16` inline. The scale below maps to named tokens so spacing restyles globally and stays consistent ([DesignTokens](DesignTokens.md)).
- **Whitespace defers to content.** Generous, even spacing is part of "defer to the user's content" — a calm surface is mostly space ([principle 2](DesignPhilosophy.md)).

## Spacing scale

Aligned to the 8-pt grid (the existing `Window`/`Widget` constants are the anchor points):

| Token | Value | Use |
|---|---|---|
| `xs` | 4 | Icon-to-label gap, tight inline spacing |
| `s` | 8 | Related controls; the snap-grid unit (`snapGrid`) |
| `m` | 16 | Default content padding inside a card/panel |
| `l` | 24 | Section separation within a panel |
| `xl` | 32 | Major region separation, panel margins |

Anchored to code: widget/window content padding is `12` (`Widget.padding`, `Window.defaultPadding`) — a half-step used for the *inner* padding of dense widgets; outer margins use `defaultMargin = 20`, rounding toward the `xl` end of the scale. The grid stays 8; `12`/`20` are the existing half-steps the code uses for compact chrome and are kept as-is to avoid code/design drift ([ADR-0012](../Decisions/ADR-0012-semantic-design-token-architecture.md)).

## The grids

- **Widget snap grid (desktop).** Widgets place and resize on an 8-point grid ([CGSize/CGPoint extensions](../../desktop-frame/Core/Extensions/CGSize+Extensions.swift) `snapped(to:)`). Snapping is what keeps a freely-arranged desktop from looking messy ([UX/WidgetUX](../UX/WidgetUX.md)). Widget sizes are clamped to `minimumSize 80×60 … maximumSize 960×640`, default `200×150`.
- **Layout grid (panels/settings).** Inspector, settings, and dashboard panels use a standard macOS form/list metric: aligned label columns, 8-pt row rhythm, and `m` content insets. Multi-column galleries (wallpaper, theme, marketplace) use an adaptive grid of fixed-min-width cells that reflow by available width.

## Density

Desktop Frame targets the standard macOS **comfortable** density; it does not ship a separate compact mode in v1. Widgets choose their own internal density within their size class (a small widget shows less, not the same content smaller). Density never comes from shrinking type below Dynamic Type's floor.

## Responsive behaviour

The surface spans the whole desktop and adapts to display and window changes:

- **Display size / resolution / scale.** Layouts are point-based and resolution-independent; per-display layouts are owned by [MultiMonitorArchitecture](../Architecture/MultiMonitorArchitecture.md) and [ADR-0009](../Decisions/ADR-0009-per-display-independent-layouts.md).
- **Widget size classes.** A widget defines layouts for its size ranges (compact / regular / expanded) and switches at thresholds rather than scaling one layout. Specified per widget in [Components/Widgets](../Components/Widgets.md).
- **Panel resize.** Settings and inspector panels have a sensible minimum size and reflow columns/lists; they never allow content to clip.
- **Reflow on reconfiguration.** When a display is removed or rearranged, layouts reflow per the multi-monitor reconcile rules, not by absolute coordinates.

## Accessibility

Spacing tracks Dynamic Type where it borders text (via `@ScaledMetric`), so larger text keeps its breathing room; hit targets meet the platform minimum regardless of visual size ([AccessibilityDesign](AccessibilityDesign.md)).

## Performance

A point-based grid and size-class switching avoid per-frame layout maths; snapping is integer-grid arithmetic. Reflow happens on configuration-change events, not continuously ([PerformanceStandards](../Standards/PerformanceStandards.md)).

## Trade-offs

- A single density keeps the system simple but may feel roomy to power users wanting more on screen; deferred until evidence justifies a compact mode.
- Keeping the code's `12`/`20` half-steps alongside the 8-pt scale is a small inconsistency accepted to keep design and code one source rather than renumbering shipping constants.

## Future evolution

A compact density and a user-tunable surface margin are natural additions once usage data exists. The adaptive gallery grid generalises to the marketplace as it grows.

## Open questions

- Whether to formalise the `12`/`20` half-steps as named tokens (`sm`/`lg`) or keep them as documented exceptions.

## References

1. [DesignTokens](DesignTokens.md) · [MultiMonitorArchitecture](../Architecture/MultiMonitorArchitecture.md) · [ADR-0009](../Decisions/ADR-0009-per-display-independent-layouts.md).
2. Apple, "HIG — Layout." https://developer.apple.com/design/human-interface-guidelines/layout

## Completion checklist
- [x] Spacing scale defined and anchored to constants.
- [x] Both grids, density, and responsive behaviour specified.
- [x] Accessibility and performance covered.

## Review checklist
- [ ] Half-step exceptions resolved or accepted in review.
- [ ] Reconciled with widget size-class definitions.
- [ ] Meets DocumentationStandards.
