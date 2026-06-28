---
title: Accessibility design
status: Active
owner: Accessibility Specialist
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [../Standards/AccessibilityStandards.md, DesignSystem.md, ColorSystem.md, MotionSystem.md, ../UX/InteractionModel.md]
---

# Accessibility design

The design-side patterns that make Desktop Frame accessible by default: how VoiceOver, full-keyboard control, Reduce Motion, Reduce Transparency, Increase Contrast, Dynamic Type, and localisation are *designed in* through the token and component system, not bolted on. The enforceable bar is [AccessibilityStandards](../Standards/AccessibilityStandards.md); this document is how the design meets it, and it carries the patterns the project's `ios-accessibility` skill implements.

## Purpose and scope

In scope: the design patterns for each accessibility dimension and where they live in the token/component system. Out of scope: the pass/fail requirements ([AccessibilityStandards](../Standards/AccessibilityStandards.md)) and the quality gate ([QualityGates](../Processes/QualityGates.md)).

## Design principle

Accessibility is a property of the **system**, not of each screen. Because surfaces read tokens and use the shared components, a single correct implementation makes every widget accessible: appearance, contrast, motion, transparency, and type are resolved globally ([DesignSystem](DesignSystem.md)). A widget becomes inaccessible only by opting out — hard-coding a colour, a size, or a bespoke control — which fails review.

## VoiceOver

- Every interactive element has a label; non-obvious actions add a hint; stateful elements expose a value ([AccessibilityStandards](../Standards/AccessibilityStandards.md)).
- Decorative elements (illustrations, separators, ambient motion) are hidden from assistive tech.
- Reading and focus order matches the visual order; a widget is a single grouped element with its controls inside, so VoiceOver does not wander.
- The desktop surface, widgets, toolbars, and settings each form a coherent rotor structure; custom rotors group widgets by region where helpful.
- Focus is restored after a transient surface (popover, sheet) closes, using focus state rather than guesswork.

## Full keyboard control

- Every action is reachable without a pointer: add/remove/move/resize a widget, open settings, switch panes, operate every control ([InteractionModel](../UX/InteractionModel.md)).
- Focus is always visible — the accent focus ring, never a colour change alone.
- Tab order follows the visual layout; arrow keys nudge a selected widget on the grid; standard macOS shortcuts are honoured and never overridden.
- Full Keyboard Access (the system setting) works across the whole experience, including the desktop surface.

## Reduce Motion

Resolved through motion tokens ([MotionSystem](MotionSystem.md)): position/scale transitions collapse to instant changes or short cross-fades; springs settle immediately; ambient/looping motion pauses. No state is signalled by motion alone — an animated change also changes a static property.

## Reduce Transparency

Resolved through material tokens ([MaterialsAndElevation](MaterialsAndElevation.md)): `glass`/`blur` resolve to `opaque` with the role colour, so every surface stays legible without vibrancy. Designs are checked with the setting on; no text is left sitting on bare wallpaper.

## Increase Contrast

Colour roles resolve to higher-contrast variants; borders strengthen and may replace shadow as the depth cue ([ColorSystem](ColorSystem.md), [MaterialsAndElevation](MaterialsAndElevation.md)). Every text/surface pair clears the platform contrast guidance in both normal and high-contrast modes. Colour is never the only carrier of meaning — status and selection always add an icon, label, or shape.

## Dynamic Type

Text uses standard text styles and scales with the user's preferred size; spacing and icon sizes that border text track it via `@ScaledMetric` ([Typography](Typography.md), [LayoutAndSpacing](LayoutAndSpacing.md)). Layouts are validated at the largest accessibility sizes — widgets reflow or switch size-class layout, never clip.

## Localisation, internationalisation, and RTL

- All user-facing strings are localised; none are concatenated from fragments (which breaks grammar and RTL).
- Layouts use leading/trailing, so the interface mirrors correctly in right-to-left languages; icons that imply direction are flipped where appropriate.
- Layouts tolerate ~30–40% text growth; numbers, dates, durations, and byte counts are formatted with `FormatStyle` so they localise.
- The design never bakes text into images.

## Accessibility testing (design's part)

Each new or changed surface gets a VoiceOver walkthrough, a full-keyboard pass with visible focus, and a toggle of Reduce Motion / Reduce Transparency / Increase Contrast / largest Dynamic Type, before it is "done" ([AccessibilityStandards](../Standards/AccessibilityStandards.md) verification). Automated checks (XCTest accessibility audits) run in CI where they exist.

## Performance

Accessibility resolution is part of token resolution — once per setting change, not per frame — so it carries no runtime cost on the hot path ([ThemeSystem](../Architecture/ThemeSystem.md)).

## Trade-offs

- Requiring every theme and widget to satisfy contrast/Dynamic-Type/RTL adds authoring cost and constrains expressive layouts; it is non-negotiable and is the price of "accessible by default".

## Future evolution

A reusable accessibility-audit checklist and automated contrast/Dynamic-Type snapshot tests become part of the component library's CI as it grows. Voice Control and Switch Control labelling extends the same label/hint metadata already required for VoiceOver.

## Open questions

- Whether to provide a built-in high-contrast theme in addition to honouring the system setting.

## References

1. [AccessibilityStandards](../Standards/AccessibilityStandards.md) · [MotionSystem](MotionSystem.md) · [ColorSystem](ColorSystem.md) · project `ios-accessibility` skill.
2. Apple, "HIG — Accessibility." https://developer.apple.com/design/human-interface-guidelines/accessibility

## Completion checklist
- [x] Each accessibility dimension has a design pattern tied to the token/component system.
- [x] Testing responsibilities and global-resolution principle stated.
- [x] Localisation/RTL and Dynamic Type covered.

## Review checklist
- [ ] Patterns reconciled with the ios-accessibility skill and AccessibilityStandards.
- [ ] Verified with VoiceOver/keyboard/Reduce-Motion passes on real surfaces.
- [ ] Meets DocumentationStandards.
