---
title: Iconography
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [DesignSystem.md, DesignTokens.md, ColorSystem.md, ../Components/README.md, AccessibilityDesign.md]
---

# Iconography

How Desktop Frame uses symbols: **SF Symbols by default**, so every icon inherits weight, scale, colour, and Dynamic Type from its context and matches the rest of macOS. Custom icons are rare, templated, and held to the same rules. This document owns icon style, symbol usage, the categories of icon in the product, and illustration guidelines.

## Purpose and scope

In scope: icon style and rendering modes, SF Symbols usage, the icon categories (toolbar/status/widget/plugin), custom-icon rules, and illustration. Out of scope: the components that contain icons ([Components](../Components/README.md)) and colour roles ([ColorSystem](ColorSystem.md)).

## Design principles

- **SF Symbols first.** A symbol that exists in SF Symbols is used from there, never redrawn. It scales crisply, aligns to the text baseline, supports rendering modes, and ships with accessibility metadata ([principle 1](DesignPhilosophy.md)).
- **Inherit, don't specify.** Icons take weight and scale from the surrounding type/context; they are tinted with colour *roles* (`textSecondary`, `accent`), never literal colours ([ColorSystem](ColorSystem.md)).
- **Recognisable over clever.** Use the conventional symbol for an action (`gearshape` for settings, `plus` for add). Novel iconography costs recognition for nothing.

## Symbol usage

- **Rendering modes:** monochrome by default; hierarchical or palette only where it aids legibility; multicolor reserved for symbols whose meaning is colour (battery, status). Mode is chosen per context, consistently.
- **Weight & scale:** match the adjacent text style; toolbar icons use the medium weight; selected/active icons may step to semibold rather than changing colour alone.
- **Variable symbols:** use SF Symbols' variable rendering for level indicators (volume, signal, battery) instead of swapping discrete glyphs.
- **Alignment:** icons align to the text baseline and the 8-pt grid; icon-plus-label uses the `xs` gap ([LayoutAndSpacing](LayoutAndSpacing.md)).

## Icon categories

| Category | Use | Source |
|---|---|---|
| Toolbar / control icons | Actions in toolbars, inspectors, menus | SF Symbols, medium weight |
| Status icons | System state in widgets (CPU, battery, network, weather) | SF Symbols, often variable/multicolor |
| Widget glyphs | A widget's identity in pickers and headers | SF Symbol where one fits; else a custom templated symbol |
| Plugin / marketplace icons | Third-party widget identity | Author-supplied, constrained by the plugin asset spec ([PluginSDK](../Architecture/PluginSDK.md)) |
| App icon | Desktop Frame's own identity | Custom, macOS app-icon grid and materials |

## Custom icons

When no SF Symbol fits, a custom icon is drawn as a **symbol image** (SVG template in `Assets.xcassets`) so it behaves like an SF Symbol: single-path, template-rendered, inheriting weight/scale/colour, with the three SF Symbols weights (small/medium/large) provided. Custom icons follow SF Symbols' optical sizing and stroke conventions so they sit beside system symbols without looking foreign. A custom icon that cannot be a template image (it needs fixed colours) is a last resort and is documented as an exception.

## Plugin icons

Third-party widgets supply their own identity icon within a constrained spec (size, safe area, template vs full-colour rules) defined by the [Plugin SDK](../Architecture/PluginSDK.md). The marketplace enforces it at review so third-party icons stay coherent in pickers and the catalogue ([Components/Marketplace](../Components/Marketplace.md)).

## Illustration

Illustrations appear only in empty states and onboarding ([Components/StatesAndFeedback](../Components/StatesAndFeedback.md)). They are light, line-based, monochrome-or-duotone using colour roles, and quiet — never marketing-grade or attention-grabbing on the surface. Each ships light/dark variants and is named by role. Illustration is the exception, not a recurring decorative element.

## Accessibility

Every meaningful icon has an accessibility label; an icon-only button is never unlabeled ([AccessibilityStandards](../Standards/AccessibilityStandards.md)). Decorative icons are hidden from assistive tech. Icons that carry state pair the glyph with a label or value so meaning survives without colour or shape recognition. SF Symbols scale with Dynamic Type when sized in text terms.

## Performance

SF Symbols are vector and atlas-cached by the system — effectively free. Custom symbol images are single small vectors. Variable symbols update by parameter, not by reloading a new asset, so frequent state changes (battery, signal) are cheap.

## Trade-offs

- Constraining authors to templated symbols limits expressive icons; the payoff is a coherent, scalable, accessible icon set.
- Reserving illustration to empty/onboarding states keeps the surface calm at the cost of visual richness — intentional.

## Future evolution

A small curated custom-symbol set may grow for concepts macOS has no symbol for (e.g. "desktop layout"). The plugin icon spec and marketplace review tooling formalise as third-party widgets scale.

## Open questions

- Whether status widgets should default to multicolor or hierarchical symbols for the calmest legible result.

## References

1. [DesignTokens](DesignTokens.md) · [PluginSDK](../Architecture/PluginSDK.md) · [Components/StatesAndFeedback](../Components/StatesAndFeedback.md).
2. Apple, "SF Symbols." https://developer.apple.com/sf-symbols/
3. Apple, "HIG — Icons." https://developer.apple.com/design/human-interface-guidelines/icons

## Completion checklist
- [x] Icon style, rendering modes, and categories defined.
- [x] Custom-icon and plugin-icon rules stated.
- [x] Illustration, accessibility, and performance covered.

## Review checklist
- [ ] Custom symbol set reconciled with the plugin asset spec.
- [ ] Icon labels verified with VoiceOver.
- [ ] Meets DocumentationStandards.
