---
title: Surfaces
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [ComponentArchitecture.md, README.md, ../Design/MaterialsAndElevation.md, ../UX/WidgetUX.md, ../Architecture/DesktopEngine.md]
---

# Surfaces

The container components everything else sits in: the Desktop Canvas, the Glass Panel every panel descends from, the Widget Container chrome, the Widget Card body, the Dashboard Panel, and the Sidebar. They define the product's depth and material language ([MaterialsAndElevation](../Design/MaterialsAndElevation.md)). Shared anatomy, state, and variant meaning are in [ComponentArchitecture](ComponentArchitecture.md); this doc states each surface's specifics.

## Purpose and scope

In scope: the six surface components and their behaviour. Out of scope: the window layer they live on ([WindowSystem](../Architecture/WindowSystem.md)) and interaction mechanics ([UX/InteractionModel](../UX/InteractionModel.md)).

## Desktop Canvas

- **Purpose.** The full-desktop interactive surface that hosts widgets and renders behind app windows ([DesktopEngine](../Architecture/DesktopEngine.md)).
- **Usage.** One per display; holds the wallpaper layer beneath and the widget layer above; routes input to widgets or passes it through to the Finder desktop.
- **Variants.** Rest mode (calm, no chrome) · Edit mode (grid + handles visible).
- **States.** Rest · Edit · Dragging-widget · Empty (no widgets → [StatesAndFeedback](StatesAndFeedback.md)).
- **Sizing.** Spans the display; point-based, per-display layout ([ADR-0009](../Decisions/ADR-0009-per-display-independent-layouts.md)).
- **Spacing.** Outer `margin (20)`; widgets snap to the 8-pt grid.
- **Accessibility.** A navigable container; widgets are its grouped children in visual order; full-keyboard add/move/resize ([AccessibilityDesign](../Design/AccessibilityDesign.md)).
- **Keyboard.** Enter/exit edit mode; arrow-nudge selected widget; tab between widgets.
- **Animation.** Edit-mode chrome fades in/out (`motion.default`); grid appears with it.
- **Performance.** Only visible widgets render/animate; wallpaper is power-aware ([RenderingEngine](../Architecture/RenderingEngine.md)).
- **Guidelines.** Calm at rest; affordances only on intent. Never draw chrome over Finder icons' own layer.

## Glass Panel

- **Purpose.** The base translucent container all panels are built from; owns material, radius, border, and elevation.
- **Usage.** Inspector, Dashboard, popovers, dialogs, sidebars compose from it.
- **Variants.** `glass` (default) · `blur` (overlay/HUD) · `opaque` (Reduce Transparency / dense content).
- **States.** Rest · Floating (elevation 2) · Modal (elevation 3).
- **Sizing.** Content-driven with sensible minimums; `radius.card (16)`.
- **Spacing.** `m` content insets.
- **Accessibility.** Material resolves to `opaque` under Reduce Transparency; never relies on translucency for legibility.
- **Animation.** Appears from its origin (`motion.default`).
- **Performance.** One vibrancy layer per panel; no nested blur ([MaterialsAndElevation](../Design/MaterialsAndElevation.md)).
- **Guidelines.** The single source of the product's surface look; do not hand-roll a panel background.

## Widget Container

- **Purpose.** The chrome around any widget: frame, selection ring, resize handles, drag affordance, context-menu target.
- **Usage.** Wraps every widget (built-in or third-party) so all widgets share selection, move, resize, and a11y grouping ([WidgetUX](../UX/WidgetUX.md)).
- **Variants.** Resizable · Fixed-size · Pinned ([WidgetUX](../UX/WidgetUX.md)).
- **States.** Rest · Hover (handles fade in) · Selected (accent ring + lift) · Focused (focus ring) · Dragging (elevation 2, follows cursor) · Disabled.
- **Sizing.** Clamps content to `Widget.minimumSize 80×60 … maximumSize 960×640`, default `200×150`; snaps to grid.
- **Spacing.** Handle inset and hit area meet the platform minimum; inner `widgetPadding (12)`.
- **Accessibility.** Exposes the widget as one grouped element with its controls inside; move/resize available via keyboard; labelled by the widget's name.
- **Keyboard.** Select, arrow-nudge, resize with modifier+arrows, delete.
- **Animation.** Handles `motion.fast`; snap/drop uses the spring ([MotionSystem](../Design/MotionSystem.md)).
- **Performance.** Chrome is drawn by the container, not each widget; affordances render only when revealed.
- **Guidelines.** A widget never draws its own selection/resize chrome — the container owns it.

## Widget Card

- **Purpose.** The standard widget body: optional header (icon + title + accessory), content slot, optional footer.
- **Usage.** The base for Metric Card, chart widgets, and the information widgets ([DataAndCharts](DataAndCharts.md), [Widgets](Widgets.md)).
- **Variants.** Headerless (pure content) · Header+content · Header+content+footer.
- **States.** Rest · Loading (skeleton) · Empty · Error · Configuring.
- **Sizing.** Size-class layouts (compact/regular/expanded) chosen by the container's size.
- **Spacing.** `m` content padding; `xs` icon-to-title.
- **Accessibility.** Header is the element's label; content values exposed; decorative parts hidden.
- **Animation.** Content transitions `motion.fast`; data updates avoid relayout (monospaced digits).
- **Performance.** Reuses slots; lazy content where lists are involved.
- **Guidelines.** Show less in compact, not the same content smaller ([LayoutAndSpacing](../Design/LayoutAndSpacing.md)).

## Dashboard Panel

- **Purpose.** A summon-able overlay aggregating widgets above app windows for an at-a-glance view ([WindowSystem](../Architecture/WindowSystem.md) overlay level).
- **Usage.** Invoked by shortcut/hot corner; dismissed by the same or Escape; floats over content.
- **Variants.** Full-screen scrim · Inline panel.
- **States.** Hidden · Presenting · Visible · Dismissing.
- **Sizing.** Adaptive grid of widgets; respects per-display layout.
- **Spacing.** `l`/`xl` between groups.
- **Accessibility.** Traps focus while open; restores focus on dismiss; Escape always closes.
- **Animation.** `motion.default` present/dismiss from the invoking edge; Reduce Motion → cross-fade.
- **Performance.** Built on demand; pauses ambient widgets beneath while shown.
- **Guidelines.** The Dashboard is transient and quiet; it does not replace the desktop.

## Sidebar

- **Purpose.** The navigation column for Settings and the Dashboard.
- **Usage.** Source-list style; sections of items; selection drives the detail pane ([Navigation](Navigation.md), [UX/SettingsUX](../UX/SettingsUX.md)).
- **Variants.** Settings sidebar · Dashboard sidebar.
- **States.** Item rest/hover/selected/focused; collapsed/expanded sections.
- **Sizing.** Standard source-list width with a minimum; resizable in Settings.
- **Spacing.** Standard list row rhythm (8-pt).
- **Accessibility.** Standard list semantics; arrow-key navigation; selected item announced.
- **Animation.** Selection `motion.fast`; section expand/collapse `motion.default`.
- **Performance.** Static list; no per-frame work.
- **Guidelines.** Use the system source-list look; do not invent a custom navigation metaphor.

## Trade-offs

- Centralising chrome in the container constrains how exotic a widget's frame can be; the payoff is universal selection/resize/a11y for free.
- A single Glass Panel base limits per-surface material experiments; intentional, for coherence.

## Future evolution

Widget grouping and docking ([WidgetUX](../UX/WidgetUX.md)) extend the container; the Dashboard could gain user-defined layouts. Third-party widgets inherit the container and card automatically through the SDK.

## Open questions

- Whether the Dashboard defaults to a scrim or a non-modal inline panel.

## References

1. [ComponentArchitecture](ComponentArchitecture.md) · [MaterialsAndElevation](../Design/MaterialsAndElevation.md) · [DesktopEngine](../Architecture/DesktopEngine.md) · [WidgetUX](../UX/WidgetUX.md).
2. Apple, "HIG — Layout / Windows." https://developer.apple.com/design/human-interface-guidelines/

## Completion checklist
- [x] Six surfaces specified against the shared schema.
- [x] Container-owns-chrome rule stated.
- [x] Accessibility and performance per surface covered.

## Review checklist
- [ ] Reconciled with DesktopEngine and WindowSystem.
- [ ] Verified against real widget chrome.
- [ ] Meets DocumentationStandards.
