---
title: Design system
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [README.md, DesignTokens.md, ColorSystem.md, Typography.md, LayoutAndSpacing.md, MaterialsAndElevation.md, MotionSystem.md, Iconography.md, ../Architecture/ThemeSystem.md, ../Standards/AccessibilityStandards.md, ../Templates/UISpecification.md]
---

# Design system

The visual language Desktop Frame is built from: the semantic tokens, their meaning, and the HIG rationale behind them. This document owns *what the tokens are and why*; the [ThemeSystem](../Architecture/ThemeSystem.md) owns *how they reach the screen at runtime*. The two are deliberately split so design intent and rendering mechanism evolve independently. It is the entry point to the design system; the per-group detail and the full token reference live in the linked docs below and are mapped by the [Design index](README.md).

The token groups summarised here each have a dedicated owner doc: [colour](ColorSystem.md), [type](Typography.md), [spacing/layout](LayoutAndSpacing.md), [materials/elevation](MaterialsAndElevation.md), [motion](MotionSystem.md), [iconography](Iconography.md), and the consolidated, code-anchored [token reference](DesignTokens.md). The semantic-role model is recorded in [ADR-0012](../Decisions/ADR-0012-semantic-design-token-architecture.md) and native materials in [ADR-0013](../Decisions/ADR-0013-native-materials-over-custom-translucency.md).

## Purpose and scope

In scope: the token taxonomy (colour, material, type, spacing, motion, iconography), their semantic meaning, the appearance modes, and the accessibility and HIG principles that constrain them. Out of scope: the runtime distribution and inheritance engine ([ThemeSystem](../Architecture/ThemeSystem.md)), the per-group detail and token reference (the linked Design docs), and per-screen layouts ([UISpecification](../Templates/UISpecification.md)).

## Context

A platform that will host third-party widgets needs a shared visual language, or every widget looks different and "the Mac comes first" becomes impossible to honour. Tokens are that shared language: a widget that asks for `accent` and `surface` automatically looks native, adapts to appearance, and respects the user's accessibility settings, without its author knowing how any of that works.

## Design

### Token taxonomy

Tokens are **semantic roles**, never raw values, so the same widget restyles globally when the theme changes ([ThemeSystem](../Architecture/ThemeSystem.md)):

| Group | Example tokens | Meaning |
|---|---|---|
| Colour | `surface`, `surfaceSecondary`, `accent`, `textPrimary`, `textSecondary`, `separator`, `success`/`warning`/`danger` | semantic colour roles, not hues |
| Material | `glass`, `blur`, `opaque` | native vibrancy levels (NSVisualEffectView / SwiftUI materials) |
| Type | `display`, `title`, `body`, `caption`, `mono` | semantic text styles mapped to Dynamic Type |
| Spacing | `xs`(4) `s`(8) `m`(16) `l`(24) `xl`(32) | scale aligned to the 8-pt grid (`AppConstants.Widget.snapGrid`) |
| Radius | `card`(16) `control`(8) | corner radii (`AppConstants.Window.defaultCornerRadius` = 16) |
| Motion | `fast`(0.15) `default`(0.3) `slow`(0.6); spring response 0.4 / damping 0.82 | the `AppConstants.Animation` constants |
| Icon | SF Symbols set | weight/scale inherited from context |

The motion, radius, and spacing tokens are intentionally the same constants the code already defines (`AppConstants.Animation`, `Window`, `Widget`), so the design system and the code are one source, not two.

### Appearance modes

- **Light / Dark** — follow `NSApp.effectiveAppearance` by default; colour tokens resolve per mode.
- **Glass** — native vibrancy material; the default surface look, adopting the platform's Liquid Glass direction where available rather than a custom translucency.
- **Blur** — a heavier material for overlay/HUD contexts.

Appearance is a user choice layered on the system default ([ThemeSystem](../Architecture/ThemeSystem.md)); the design system defines what each mode *means*, the theme engine applies it.

### HIG principles (the constraints)

Drawn from the macOS HIG and the constitution's "the Mac comes first" ([MacOSPlatformResearch](../Research/MacOSPlatformResearch.md)):

1. **Defer to the user's content.** The surface frames the user's work; it does not shout. Chrome is quiet, materials are native, motion is restrained.
2. **Adopt the platform.** System materials over custom blur; SF Symbols over bespoke icons; system accent honoured; standard text styles so Dynamic Type works.
3. **Respect the system settings.** Reduce Motion, Increase Contrast, Dynamic Type, and Reduce Transparency all map to token resolution, applied globally ([AccessibilityStandards](../Standards/AccessibilityStandards.md)) — never re-decided per widget.
4. **Consistency is a feature.** A button, a label, a card look the same wherever they appear, because they come from the same tokens.

### Accessibility in the tokens

Accessibility is built into the token layer, not bolted on: colour tokens carry contrast-compliant light/dark/high-contrast resolutions; type tokens are Dynamic-Type-scaled; motion tokens collapse under Reduce Motion. A widget that uses tokens is accessible by default; one that hard-codes a hue or a point size opts out and fails review ([AccessibilityStandards](../Standards/AccessibilityStandards.md)).

## Invariants

1. **Tokens are semantic roles, never raw values;** widgets never hard-code hues or point sizes.
2. **Spacing/radius/motion tokens are the `AppConstants` values;** design and code share one source.
3. **System accessibility settings resolve through tokens globally,** not per widget ([AccessibilityStandards](../Standards/AccessibilityStandards.md)).
4. **Materials are native,** not hand-rolled translucency.

## Known limitations

- The third-party theming schema (when external authors define token overrides) is a public contract not yet specified; v1 covers built-in modes and user customisation ([ThemeSystem](../Architecture/ThemeSystem.md)).
- Token values here are the initial set; they are tuned with real widgets during the surface milestones and re-baselined under design review.

## Future evolution

The token set is the contract third-party themes will target; opening theming means versioning this token vocabulary like the widget config schema ([ADR-0010](../Decisions/ADR-0010-widget-configuration-schema-versioning.md)). New token groups (e.g. depth/elevation for richer compositing) extend the taxonomy without breaking existing widgets.

## References

1. [ThemeSystem](../Architecture/ThemeSystem.md) · [AccessibilityStandards](../Standards/AccessibilityStandards.md) · [UISpecification](../Templates/UISpecification.md).
2. Apple, "Human Interface Guidelines — macOS." https://developer.apple.com/design/human-interface-guidelines/designing-for-macos
3. Apple, "SF Symbols." https://developer.apple.com/sf-symbols/

## Completion checklist
- [x] Token taxonomy defined with meanings.
- [x] Appearance modes and HIG principles stated.
- [x] Accessibility built into the token layer.
- [x] Invariants named; ThemeSystem split clarified.

## Review checklist
- [ ] Token values tuned against real widgets.
- [ ] Reconciled with ThemeSystem token names.
- [ ] Meets DocumentationStandards.
