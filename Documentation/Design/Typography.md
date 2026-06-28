---
title: Typography
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [DesignSystem.md, DesignTokens.md, AccessibilityDesign.md, ../Standards/AccessibilityStandards.md]
---

# Typography

How Desktop Frame uses type: the system font, addressed through **semantic text styles**, never fixed point sizes. A label asks for `body` or `title` and scales with the user's Dynamic Type setting, stays legible in every appearance, and matches the rest of macOS. This document owns the type scale and its usage; the values live in the token table ([DesignTokens](DesignTokens.md)).

## Purpose and scope

In scope: the type scale, the mapping to Dynamic Type, font and weight usage, and the monospace role. Out of scope: colour of text ([ColorSystem](ColorSystem.md)) and per-component text placement ([Components](../Components/README.md)).

## Design principles

- **System font only.** SF Pro (text/display optical sizes chosen by the system) for UI, SF Mono for numeric and code. No bundled custom UI fonts — they break Dynamic Type, localisation, and the native feel ([principle 1](DesignPhilosophy.md)).
- **Semantic styles, not sizes.** Views reference `theme.type.title`, never `.font(.system(size: 17))`. The style maps to a standard text style so Dynamic Type and the bold-text setting work for free.
- **Hierarchy by role, not by shouting.** Emphasis comes from style and weight steps, not from many sizes. Most surfaces use two or three styles.

## Type scale

Semantic styles mapped to the standard macOS text styles (which are themselves Dynamic-Type-scaled):

| Token | Maps to | Default use |
|---|---|---|
| `display` | Large Title | Hero numbers in a metric widget, onboarding headline |
| `title` | Title 2 / Title 3 | Panel and section headers, widget titles |
| `headline` | Headline (semibold body) | Emphasised row labels, settings group headers |
| `body` | Body | Default reading text and control labels |
| `callout` | Callout | Secondary inline text |
| `caption` | Caption 1 / Caption 2 | Annotations, axis labels, timestamps |
| `mono` | Body, `.monospaced` design | Numeric readouts (CPU %, clock), code, hex values |

Weights are limited to **regular, medium, semibold, bold**; semibold is the default emphasis step. Avoid light/thin weights — they fail contrast and legibility at small sizes on the desktop.

## Dynamic Type

Text honours the user's preferred content size. Implementation uses standard text styles (which scale automatically) and `@ScaledMetric` for any spacing or icon size that must track text ([AccessibilityDesign](AccessibilityDesign.md)). Layouts are tested at the largest accessibility sizes: a widget reflows or truncates gracefully, never clips. A widget that hard-codes a point size opts out of Dynamic Type and fails review ([AccessibilityStandards](../Standards/AccessibilityStandards.md)).

## Monospace and numerics

Live numeric readouts (CPU %, memory, clock, network rate) use the `mono` style or, where a proportional face is wanted, the **monospaced-digit** variant of the body font, so digits do not jitter as they update. Number, byte, and duration formatting is done with `FormatStyle` (`.formatted()`), not manual string building, so it localises correctly.

## Localisation and RTL

Type is laid out with leading/trailing semantics, not left/right, so the interface mirrors correctly in right-to-left languages. Text never assumes a fixed width; truncation and line-wrapping are specified per component. String length grows ~30–40% in some languages — layouts leave room ([AccessibilityDesign](AccessibilityDesign.md)).

## Accessibility

Dynamic Type and bold-text are honoured globally; minimum sizes respect the platform; contrast is owned by [ColorSystem](ColorSystem.md). No information is carried by font alone without a text or structural cue.

## Performance

Standard text styles and the system font are GPU-cached by AppKit/SwiftUI; using them avoids custom font loading and glyph-atlas churn. Frequent numeric updates use monospaced digits to avoid relayout on every tick.

## Trade-offs

- System-font-only forgoes a distinctive brand typeface; accepted, per "the Mac comes first".
- Limiting weights and styles constrains expressive layouts; the payoff is consistency and Dynamic Type for free.

## Future evolution

If third-party widgets gain richer text needs, the `mono`/`body` split may grow a small set of additional semantic roles, versioned with the token vocabulary ([ADR-0012](../Decisions/ADR-0012-semantic-design-token-architecture.md)). Custom fonts, if ever allowed for plugin content, would be sandboxed to the plugin's own surface, never the chrome.

## Open questions

- Whether `display` should be a single role or split into widget-hero vs onboarding-hero scales.

## References

1. [DesignSystem](DesignSystem.md) · [DesignTokens](DesignTokens.md) · [AccessibilityDesign](AccessibilityDesign.md).
2. Apple, "HIG — Typography." https://developer.apple.com/design/human-interface-guidelines/typography
3. Swift, "FormatStyle." (project `swift-formatstyle` skill.)

## Completion checklist
- [x] Type scale defined and mapped to standard styles.
- [x] Dynamic Type, monospace, and RTL covered.
- [x] Accessibility and performance stated.

## Review checklist
- [ ] Scale reconciled with DesignTokens and ThemeSystem type tokens.
- [ ] Verified at largest accessibility sizes against real widgets.
- [ ] Meets DocumentationStandards.
