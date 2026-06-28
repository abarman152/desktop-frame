---
title: Colour system
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [DesignSystem.md, DesignTokens.md, MaterialsAndElevation.md, AccessibilityDesign.md, ../Architecture/ThemeSystem.md]
---

# Colour system

How Desktop Frame uses colour: as a small set of **semantic roles**, resolved per appearance and accessibility setting, never as raw hues hard-coded into a view. A widget asks for `textPrimary` or `accent` and is correct in light, dark, high-contrast, and any user theme, without its author knowing how. This document owns the colour roles and their resolution rules; [DesignTokens](DesignTokens.md) holds the full token table and [ThemeSystem](../Architecture/ThemeSystem.md) distributes them at runtime.

## Purpose and scope

In scope: the colour roles, the accent model, appearance resolution (light/dark/high-contrast), and opacity rules. Out of scope: materials and vibrancy ([MaterialsAndElevation](MaterialsAndElevation.md)) and the runtime theme engine ([ThemeSystem](../Architecture/ThemeSystem.md)).

## Design principles

- **Semantic, not literal.** Views reference roles (`accent`, `surface`), never `Color.blue` or a hex literal. The one sanctioned place a hex string enters the system is a *theme definition* via `Color(hex:)` ([Color+Extensions.swift](../../desktop-frame/Core/Extensions/Color+Extensions.swift)); everywhere else uses roles.
- **System colours first.** Roles resolve to AppKit dynamic system colours (`labelColor`, `windowBackgroundColor`, `separatorColor`, `controlAccentColor`) wherever one fits, so Desktop Frame inherits Apple's appearance tuning, increase-contrast variants, and future changes for free ([principle 1](DesignPhilosophy.md)).
- **Colour is never the only signal.** Status and selection always carry a second cue (icon, label, weight, position), so meaning survives colour-blindness and greyscale ([AccessibilityDesign](AccessibilityDesign.md)).

## Colour roles

| Role | Meaning | Resolves to (default) |
|---|---|---|
| `surface` | Primary widget/panel background | `windowBackgroundColor` over the active material |
| `surfaceSecondary` | Recessed/grouped background | `underPageBackgroundColor` / a step down from `surface` |
| `textPrimary` | Primary content text | `labelColor` |
| `textSecondary` | Supporting/annotation text | `secondaryLabelColor` |
| `textTertiary` | Disabled / least-emphasis text | `tertiaryLabelColor` |
| `accent` | Interactive emphasis, selection, focus | `controlAccentColor` (the user's system accent) |
| `separator` | Hairline dividers and borders | `separatorColor` |
| `success` / `warning` / `danger` | Semantic status | system green / yellow / red, appearance-aware |
| `onAccent` | Content drawn on an accent fill | `white` / appearance-aware contrast pair |

The existing `Color` extension already defines the desktop-specific roles `widgetBackground`, `widgetBorder`, `widgetPrimary`, `widgetSecondary` against these system colours ([Color+Extensions.swift](../../desktop-frame/Core/Extensions/Color+Extensions.swift)); the token names above are the design-system vocabulary the theme maps onto them.

## Accent

The accent follows the user's **system accent colour** (`controlAccentColor`) by default, so selection and focus match the rest of macOS. A theme may override the accent; a widget may not. Accent is used sparingly — for selection, focus rings, the active state of a control, and the one primary action in a view — never as a decorative fill. Over-using accent breaks "inform from the periphery" ([principle 3](DesignPhilosophy.md)).

## Appearance resolution

Every role carries a resolution per appearance; the theme resolves them, not the widget.

- **Light / Dark** — follow `NSApp.effectiveAppearance`. System-colour-backed roles adapt automatically; theme-authored roles supply both variants.
- **Increase Contrast** — when the system "Increase contrast" setting is on, roles resolve to higher-contrast variants (system colours do this for free; theme colours must declare a high-contrast pair). Every text-on-surface pair must clear the platform contrast guidance in both normal and high-contrast modes ([AccessibilityDesign](AccessibilityDesign.md)).
- **Reduce Transparency** — colour roles do not change, but the *material* behind them becomes opaque ([MaterialsAndElevation](MaterialsAndElevation.md)), so `surface` stays legible without vibrancy.

## Opacity rules

Opacity is a token, not an arbitrary value, and is used for *material tint and de-emphasis*, never to fake a missing colour role.

- Glass surface tint: the material carries translucency; the colour layer on top is near-opaque so text stays crisp (the existing `widgetBackground` uses `0.6` over `windowBackgroundColor`).
- Hairline borders: `separator` at ~`0.4` (matching `widgetBorder`).
- Disabled controls: drop to `textTertiary`/reduced opacity rather than a new grey.
- Never stack opacities to produce a colour; pick the role whose resolved value is correct.

## Accessibility

Contrast is verified for every text/surface pairing in light, dark, and high-contrast; status colours always pair with an icon or label; selection pairs accent with a shape or border change. Full requirements in [AccessibilityDesign](AccessibilityDesign.md) and [AccessibilityStandards](../Standards/AccessibilityStandards.md).

## Performance

Roles resolve to cached `NSColor`/`Color` values; resolution happens at theme-change time, not per frame ([ThemeSystem](../Architecture/ThemeSystem.md)). Dynamic system colours are GPU-cheap; the colour layer never adds a blur pass (that is the material's job).

## Trade-offs

- Leaning on system colours means less brand colour expression — accepted, per "the Mac comes first".
- Requiring a high-contrast pair for every theme-authored colour adds authoring cost; it is the price of accessible custom themes.

## Future evolution

When third-party themes open, the colour roles become a versioned public vocabulary ([ADR-0012](../Decisions/ADR-0012-semantic-design-token-architecture.md), [ADR-0010](../Decisions/ADR-0010-widget-configuration-schema-versioning.md)); a theme validator will reject palettes that fail contrast in any required mode.

## Open questions

- Whether to ship a curated set of accent-tinted built-in themes, or only system-accent-following light/dark, in v1 ([ThemeSystem](../Architecture/ThemeSystem.md) open question).

## References

1. [DesignSystem](DesignSystem.md) · [DesignTokens](DesignTokens.md) · [ThemeSystem](../Architecture/ThemeSystem.md) · [AccessibilityDesign](AccessibilityDesign.md).
2. Apple, "HIG — Color." https://developer.apple.com/design/human-interface-guidelines/color
3. Apple, "NSColor — system colors." https://developer.apple.com/documentation/appkit/nscolor

## Completion checklist
- [x] Colour roles defined with default resolutions.
- [x] Accent, appearance, and opacity rules stated.
- [x] Accessibility and performance covered.

## Review checklist
- [ ] Role names reconciled with ThemeSystem and DesignTokens.
- [ ] Contrast pairs verified against real widgets.
- [ ] Meets DocumentationStandards.
