---
title: Design standards
status: Active
owner: UI/UX
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [../Design/README.md, ../Design/DesignTokens.md, ../Components/ComponentArchitecture.md, AccessibilityStandards.md, ReviewChecklist.md]
---

# Design standards

The enforceable design rules, checkable in review. Where the [Design](../Design/README.md), [Components](../Components/README.md), and [UX](../UX/README.md) docs explain *what* the design system is and *why*, this standard states the *bar* a change must clear to merge — the design counterpart to [SwiftStyleGuide](SwiftStyleGuide.md) and [AccessibilityStandards](AccessibilityStandards.md). It does not restate the detail; it points to the owning doc and makes the rule binding.

## Purpose and scope

In scope: the enforceable rules for tokens, spacing, type, colour, motion, components, interaction, visual consistency, naming, and assets. Out of scope: the rationale and detail (the linked Design/Components/UX docs).

## The rules

A change to interface does not merge unless all hold:

### Tokens
- No hard-coded colours, sizes, radii, or durations. Every value comes from a token ([DesignTokens](../Design/DesignTokens.md)). The only sanctioned literal is a hex in a *theme definition*.
- Geometry/motion tokens match `AppConstants` ([Constants.swift](../../desktop-frame/Core/Utilities/Constants.swift)); design and code stay one source ([ADR-0012](../Decisions/ADR-0012-semantic-design-token-architecture.md)).

### Spacing & layout
- Everything aligns to the 8-pt grid; spacing uses the scale tokens, not inline numbers ([LayoutAndSpacing](../Design/LayoutAndSpacing.md)).
- Hit targets meet the platform minimum regardless of visual size.

### Typography
- System font via semantic text styles; no hard-coded point sizes; Dynamic Type honoured ([Typography](../Design/Typography.md)). Weights limited to regular/medium/semibold/bold.

### Colour
- Semantic roles only; contrast verified in light, dark, and high-contrast; colour is never the sole carrier of meaning ([ColorSystem](../Design/ColorSystem.md)).

### Materials
- Native materials only (`NSVisualEffectView`/SwiftUI `Material`); no hand-rolled translucency; a legible opaque fallback under Reduce Transparency ([MaterialsAndElevation](../Design/MaterialsAndElevation.md), [ADR-0013](../Decisions/ADR-0013-native-materials-over-custom-translucency.md)).

### Motion
- Motion is meaningful, uses the motion tokens, holds the frame budget, and has a Reduce Motion alternative ([MotionSystem](../Design/MotionSystem.md)). No attention-seeking or looping decorative motion.

### Components
- Reuse a library component before inventing one; respect the state/variant vocabulary and the slot/anatomy model; never re-implement container chrome ([ComponentArchitecture](../Components/ComponentArchitecture.md)).
- A new shared component is specified in the relevant family doc before it ships.

### Interaction
- Match macOS conventions; direct-manipulation-first; every action keyboard-reachable; every manipulation undoable ([InteractionModel](../UX/InteractionModel.md), [ADR-0014](../Decisions/ADR-0014-direct-manipulation-widget-interaction-model.md)).

### Visual consistency
- A given element looks and behaves the same everywhere it appears; affordances reveal on intent and recede at rest; the surface defers to the user's content ([DesignPhilosophy](../Design/DesignPhilosophy.md)).

### Naming
- Components are `UpperCamelCase` nouns matching the catalogue; variants are enums; tokens are lowerCamelCase semantic roles ([NamingConventions](NamingConventions.md), [ComponentArchitecture](../Components/ComponentArchitecture.md)).

### Assets
- SF Symbols first; custom icons are templated symbol images; assets named by role in kebab-case with light/dark and scale variants ([Iconography](../Design/Iconography.md), [DesignTokens](../Design/DesignTokens.md) asset organisation).

## Enforcement

Checked in the design and accessibility review of every interface change, as part of the UX and accessibility quality gates ([QualityGates](../Processes/QualityGates.md), owned by UI/UX) and the [ReviewChecklist](ReviewChecklist.md). A hard-coded value, an invented one-off component, an inaccessible control, or a non-native interaction does not pass. Genuine exceptions are documented inline and accepted in review, not left implicit.

## Verification

- Grep/lint for hard-coded colours, sizes, and durations in interface code.
- A VoiceOver + full-keyboard + Reduce-Motion/Transparency + largest-Dynamic-Type pass on new interface ([AccessibilityStandards](AccessibilityStandards.md)).
- Contrast check of new colour pairings in all appearance modes.
- A frame-budget check (Instruments) for new motion or material ([PerformanceStandards](PerformanceStandards.md)).

## Common gaps

- Inline `Color`/point-size/duration literals instead of tokens.
- A one-off component duplicating a library one.
- Colour-only status or selection.
- Motion with no Reduce Motion alternative.
- Custom translucency instead of a native material.

## References

1. [Design system](../Design/README.md) · [Component architecture](../Components/ComponentArchitecture.md) · [AccessibilityStandards](AccessibilityStandards.md) · [ADR-0012](../Decisions/ADR-0012-semantic-design-token-architecture.md)/[0013](../Decisions/ADR-0013-native-materials-over-custom-translucency.md)/[0014](../Decisions/ADR-0014-direct-manipulation-widget-interaction-model.md).
2. Apple, "Human Interface Guidelines — macOS." https://developer.apple.com/design/human-interface-guidelines/designing-for-macos
