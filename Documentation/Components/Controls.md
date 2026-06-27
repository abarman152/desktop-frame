---
title: Controls
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [ComponentArchitecture.md, README.md, ../Design/ColorSystem.md, ../Design/Iconography.md, ../UX/InteractionModel.md]
---

# Controls

The interactive primitives: buttons, segmented controls, dropdowns/menus, sliders, the colour and icon pickers, and the search bar with results. They are the most reused components, so they are the strictest about matching macOS conventions ([principle 1](../Design/DesignPhilosophy.md)). Shared state/variant meaning is in [ComponentArchitecture](ComponentArchitecture.md); this doc states each control's specifics.

## Purpose and scope

In scope: the seven control components and their behaviour. Out of scope: where they are placed (the [Navigation](Navigation.md) and [UX](../UX/README.md) docs) and the tokens they consume ([DesignTokens](../Design/DesignTokens.md)).

## Button

- **Purpose.** Trigger an action.
- **Variants.** `primary` (one per view, accent fill) · `secondary` (bordered) · `tertiary` (text-only) · `destructive` (danger) · `icon` (SF Symbol, square hit target).
- **States.** Rest · Hover · Pressed · Focused · Disabled · Loading (inline spinner, label held).
- **Sizing.** `small | regular | large`; icon buttons keep a full-size hit target.
- **Spacing.** `m` horizontal padding; `xs` icon-to-label.
- **Accessibility.** Label always present (icon buttons too); destructive announces its nature; disabled exposes the trait.
- **Keyboard.** Default button responds to Return; Escape triggers cancel; full keyboard focus.
- **Animation.** Press/hover `motion.fast`.
- **Performance / guidelines.** Use the system button look; reserve `primary`/accent for the single main action.

## Segmented Control

- **Purpose.** One choice among 2–5 mutually exclusive options.
- **Variants.** Text · Icon · Text+icon.
- **States.** Per-segment rest/hover/selected/focused/disabled.
- **Sizing.** Equal-width segments; `control` radius.
- **Accessibility.** Exposes selected segment; arrow keys move selection.
- **Keyboard.** Left/right to change selection; not for >5 options (use a dropdown).
- **Guidelines.** For more than five options or long labels, use a Dropdown instead.

## Dropdown / Menu

- **Purpose.** A choice from a longer list, or a set of contextual actions (pull-down).
- **Variants.** Pop-up (current value shown) · Pull-down (actions) · with section headers / submenus.
- **States.** Closed/open; item rest/hover/selected/disabled.
- **Accessibility.** Native menu semantics; type-to-select; current value announced.
- **Keyboard.** Space/Return opens; arrows navigate; type-ahead.
- **Animation.** System menu appearance.
- **Guidelines.** Use the native `NSMenu`/SwiftUI `Menu`; group and separate long lists; keep labels short.

## Slider

- **Purpose.** A continuous or stepped value (opacity, size, refresh interval).
- **Variants.** Continuous · Stepped (tick marks) · With value label.
- **States.** Rest · Dragging · Focused · Disabled.
- **Accessibility.** Exposes value and range; adjustable via VoiceOver and arrow keys.
- **Keyboard.** Arrow keys step; modifier for fine/coarse.
- **Animation.** Thumb follows 1:1; no easing on the drag.
- **Guidelines.** Pair with a precise field where exact values matter; show units.

## Color Picker

- **Purpose.** Choose a colour for a theme accent or colour token ([ColorSystem](../Design/ColorSystem.md)).
- **Variants.** Swatch grid (token-safe presets) · System colour panel (advanced).
- **States.** Swatch rest/hover/selected/focused; panel open.
- **Accessibility.** Swatches labelled by name and value, not colour alone; selection has a shape cue.
- **Keyboard.** Arrow-navigate swatches; Return selects; opens the system panel for custom.
- **Guidelines.** Default to token-safe presets that pass contrast; the raw system panel is the advanced path, and custom colours are validated for contrast ([AccessibilityDesign](../Design/AccessibilityDesign.md)).

## Icon Picker

- **Purpose.** Choose an SF Symbol for a widget, shortcut, or label ([Iconography](../Design/Iconography.md)).
- **Variants.** Searchable grid · Categorised browse.
- **States.** Symbol rest/hover/selected/focused; searching; no-results (empty state).
- **Accessibility.** Each symbol exposes its name; search is keyboard-first.
- **Keyboard.** Type to filter; arrow-navigate; Return selects.
- **Guidelines.** Restricted to SF Symbols so every chosen icon inherits weight/scale/colour and stays native.

## Search Bar & Results

- **Purpose.** Search settings, widgets, or the marketplace.
- **Variants.** Inline (toolbar) · Prominent (settings/marketplace) · With scope filters.
- **States.** Empty · Typing · Results · No-results (empty state) · Loading (marketplace).
- **Accessibility.** Standard search-field semantics; results are a navigable list; result count announced.
- **Keyboard.** Cmd-F focuses; arrows move through results; Return opens; Escape clears.
- **Animation.** Results update `motion.fast`; no jarring relayout while typing.
- **Performance.** Debounced query; results virtualised for long lists ([EngineeringHandoff](../Design/EngineeringHandoff.md)).
- **Guidelines.** Match the macOS search field; show a clear no-results state with a next step.

## Trade-offs

- Mandating native control looks limits bespoke styling; the payoff is familiarity, accessibility, and free platform updates.
- Restricting segmented controls to ≤5 options and icons to SF Symbols trades flexibility for consistency.

## Future evolution

Controls gain a documented disabled-reason tooltip and a compact density if a power-user mode arrives. Plugin authors get a constrained subset of controls via the SDK so third-party config UIs stay native ([PluginSDK](../Architecture/PluginSDK.md)).

## Open questions

- Whether the colour picker should ever expose fully unconstrained colours, given the contrast guarantee.

## References

1. [ComponentArchitecture](ComponentArchitecture.md) · [ColorSystem](../Design/ColorSystem.md) · [Iconography](../Design/Iconography.md).
2. Apple, "HIG — Buttons / Menus / Selectors." https://developer.apple.com/design/human-interface-guidelines/components

## Completion checklist
- [x] Seven controls specified against the shared schema.
- [x] Keyboard and accessibility per control stated.
- [x] Native-convention and contrast rules noted.

## Review checklist
- [ ] Reconciled with InteractionModel keyboard map.
- [ ] Verified against native control behaviour.
- [ ] Meets DocumentationStandards.
