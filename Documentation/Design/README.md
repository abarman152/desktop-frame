---
title: Design index
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [DesignPhilosophy.md, DesignSystem.md, ../README.md, ../Components/README.md, ../UX/README.md]
---

# Design index

The map of Desktop Frame's design architecture: the philosophy, the design system, and the rules that turn "the Mac comes first" into concrete tokens, components, and interactions. This is the design counterpart to the [Architecture index](../Architecture/README.md). Everything here is design *architecture* — the documented language an engineer implements against — not production UI. The component catalogue lives next door in [Components](../Components/README.md) and the experience model in [UX](../UX/README.md).

## Read in this order

1. [Design philosophy](DesignPhilosophy.md) — the principles and personality every other document serves.
2. [Design system](DesignSystem.md) — the token taxonomy and the HIG constraints (the canonical token doc).
3. [Design tokens](DesignTokens.md) — the consolidated token reference, naming, and asset organisation.
4. The token detail docs below, then [Components](../Components/README.md), then [UX](../UX/README.md).

## The design system

| Document | Owns |
|---|---|
| [Design philosophy](DesignPhilosophy.md) | Principles, personality, interaction philosophy, decision rules, trade-offs |
| [Design system](DesignSystem.md) | The semantic token taxonomy and HIG rationale (canonical) |
| [Design tokens](DesignTokens.md) | The full token reference table, token naming, asset organisation |
| [Colour system](ColorSystem.md) | Accent, semantic colour roles, light/dark/high-contrast resolution, opacity |
| [Typography](Typography.md) | Type scale, Dynamic Type mapping, font and mono usage |
| [Layout and spacing](LayoutAndSpacing.md) | Spacing scale, the 8-pt grid, layout grid, density, responsive behaviour |
| [Materials and elevation](MaterialsAndElevation.md) | Glass/blur/opaque materials, corner radius, shadow, border, elevation |
| [Motion system](MotionSystem.md) | Motion philosophy, durations, spring curves, transitions, Reduce Motion |
| [Iconography](Iconography.md) | SF Symbols usage, custom/status/widget/plugin icons, illustration |
| [Theme architecture](ThemeArchitecture.md) | Design-side theme model, custom themes, brand identity, token versioning |
| [Accessibility design](AccessibilityDesign.md) | The design-side accessibility patterns behind the standard |
| [Engineering handoff](EngineeringHandoff.md) | SwiftUI/AppKit, animation, performance, a11y, testing guidance per family |

## Related

- [Components](../Components/README.md) — the reusable component library built from these tokens.
- [UX](../UX/README.md) — the interaction model, widget/wallpaper/settings experience, IA, and flows.
- [ThemeSystem](../Architecture/ThemeSystem.md) — the *runtime* engine that distributes the tokens this design system defines.
- [Standards/DesignStandards](../Standards/DesignStandards.md) — the enforceable design rules; [AccessibilityStandards](../Standards/AccessibilityStandards.md) — the accessibility bar.
- [Decisions](../Decisions/README.md) — ADR-0012…0015 record the architectural design decisions.

## How design intent stays one source

The design system and the code share one source of values: spacing, radius, and motion tokens *are* the `AppConstants` the code already defines ([Constants.swift](../../desktop-frame/Core/Utilities/Constants.swift)). The design system says what each token *means*; the [ThemeSystem](../Architecture/ThemeSystem.md) says how it reaches the screen. Neither restates the other.
