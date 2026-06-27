---
title: Widget UX
status: Active
owner: UI/UX
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [InteractionModel.md, ../Components/Surfaces.md, ../Components/Widgets.md, ../Architecture/WidgetEngine.md, ../Decisions/ADR-0014-direct-manipulation-widget-interaction-model.md]
---

# Widget UX

The complete experience of living with widgets: adding, moving, resizing, configuring, grouping, layering, docking, pinning, snapping, persisting, and editing them. It applies the [interaction model](InteractionModel.md) to widgets specifically, and is the experience layer over the [WidgetEngine](../Architecture/WidgetEngine.md) and the [Widget Container/Card](../Components/Surfaces.md) components.

## Purpose and scope

In scope: every user-facing widget operation and its feedback. Out of scope: widget lifecycle, config schema, and isolation ([WidgetEngine](../Architecture/WidgetEngine.md), [ADR-0010](../Decisions/ADR-0010-widget-configuration-schema-versioning.md)) and the content design of built-ins ([Components/Widgets](../Components/Widgets.md)).

## Design principles

- **Configurable without code** ([principle 5](../Design/DesignPhilosophy.md)): everything is direct manipulation or a settings control.
- **Reversible:** every operation is undoable ([InteractionModel](InteractionModel.md)); the design avoids confirm dialogs.
- **Calm:** editing affordances appear on intent and vanish at rest.

## Adding a widget

Entry points: the canvas context menu ("Add widget…"), an "+" in edit mode, or the widget library/marketplace ([Components/Marketplace](../Components/Marketplace.md)). The user picks from a categorised, searchable library (each entry shows the widget's identity icon and a live preview), then places it — it appears at the drop point with a `motion.default` scale+fade and snaps to the grid. A newly added widget that needs permission or configuration opens its inspector immediately ([Components/Widgets](../Components/Widgets.md) permission states).

## Removing a widget

Via context menu, the floating toolbar, or Delete on a selection. Removal animates out (`motion.default`) and is **undoable**; no confirm dialog for a single widget. Removing many at once shows a single undoable action. Uninstalling a third-party widget's *data* is the rare confirming, non-undoable case ([Components/Marketplace](../Components/Marketplace.md)).

## Moving, resizing, snapping

Move by dragging the widget; resize by an edge or corner handle (revealed on hover/selection). Both snap to the 8-pt grid and to neighbour edges/guides in edit mode, settling with the spring; sizes clamp to `minimumSize…maximumSize` ([InteractionModel](InteractionModel.md), [LayoutAndSpacing](../Design/LayoutAndSpacing.md)). Keyboard: arrows nudge, modifier+arrows resize. A widget switches size-class layout (compact/regular/expanded) at thresholds rather than scaling ([Components/Widgets](../Components/Widgets.md)).

## Configuring and editing

Selecting a widget shows its properties in the inspector ([Components/Navigation](../Components/Navigation.md)): data source, appearance within tokens, refresh, size behaviour. Common properties are first; advanced is behind a disclosure ([InformationArchitecture](InformationArchitecture.md)). Changes preview live and are undoable. "Edit widget" enters a focused config sheet for multi-step setup ([Components/Overlays](../Components/Overlays.md)).

## Grouping and layering

- **Grouping.** Multiple widgets can be grouped to move/arrange together; a group is itself selectable and undoable. Groups are a convenience over the layout, not a new container type.
- **Layering.** Widgets have a front-to-back order (bring forward/send back) for the rare overlap; the default is non-overlapping via snapping, so layering is an edge case, not the norm.

## Docking and pinning

- **Docking.** A widget can dock to a screen edge/corner, staying anchored as the layout or display changes ([MultiMonitorArchitecture](../Architecture/MultiMonitorArchitecture.md) reflow).
- **Pinning.** A pinned widget is locked from accidental move/resize (and optionally from selection) — useful for a finished arrangement; unpinning restores manipulation. Pin state is visible and toggled from the context menu/floating toolbar.

## Persistence

Layout — position, size, config, group, dock, pin, per-display and (future) per-Space — persists across launches and survives display reconfiguration, stored with the layout document ([ADR-0008](../Decisions/ADR-0008-persistence-strategy.md), [ADR-0009](../Decisions/ADR-0009-per-display-independent-layouts.md)). A config-schema change migrates safely ([ADR-0010](../Decisions/ADR-0010-widget-configuration-schema-versioning.md)). The user never loses an arrangement to an update or a monitor unplug.

## Accessibility

Every operation is keyboard- and VoiceOver-operable: add (from a navigable library), move/resize (arrows), configure (the inspector form), remove (Delete + undo), group/pin (menu actions). A widget is one grouped element with its controls inside; affordances appear on focus as on hover ([AccessibilityDesign](../Design/AccessibilityDesign.md)).

## Performance

Manipulation holds the refresh rate; only the dragged widget and visible widgets render; persistence writes are debounced, not per-move; the library's previews are downscaled and lazy ([RenderingEngine](../Architecture/RenderingEngine.md), [WidgetEngine](../Architecture/WidgetEngine.md)).

## Trade-offs

- Free-form placement with snapping (rather than a fixed grid of slots) is more work and allows messier layouts, but matches the "your desktop" mental model and the direct-manipulation principle ([Research](../Research/DesktopCustomizationUXResearch.md)).
- Making layering an edge case keeps the default tidy but limits intentional overlap designs; acceptable.

## Future evolution

Per-Space layouts, alignment guides, smart-arrange, and shared/exportable layouts; group templates. Third-party widgets get all of this for free through the container ([Components/Surfaces](../Components/Surfaces.md)).

## Open questions

- Whether grouping ships in v1 or follows the core add/move/resize/configure loop.
- Default behaviour when two displays of differing size swap — reflow vs preserve-and-clip ([MultiMonitorArchitecture](../Architecture/MultiMonitorArchitecture.md)).

## References

1. [InteractionModel](InteractionModel.md) · [WidgetEngine](../Architecture/WidgetEngine.md) · [Components/Surfaces](../Components/Surfaces.md) · [ADR-0014](../Decisions/ADR-0014-direct-manipulation-widget-interaction-model.md).
2. Apple, "HIG — Widgets." https://developer.apple.com/design/human-interface-guidelines/widgets

## Completion checklist
- [x] Every widget operation specified with feedback and undo behaviour.
- [x] Persistence, docking, pinning, grouping, layering covered.
- [x] Accessibility and performance per operation stated.

## Review checklist
- [ ] Reconciled with WidgetEngine lifecycle and persistence.
- [ ] Keyboard parity verified for every operation.
- [ ] Meets DocumentationStandards.
