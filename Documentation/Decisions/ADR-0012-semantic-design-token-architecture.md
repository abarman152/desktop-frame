---
title: ADR-0012 Semantic design-token architecture
status: Accepted
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [../Design/DesignSystem.md, ../Design/DesignTokens.md, ../Architecture/ThemeSystem.md, ADR-0003-observable-state-model.md, ADR-0010-widget-configuration-schema-versioning.md]
---

# ADR-0012: Semantic design-token architecture

## Status

Accepted — 2026-06-27.

## Context

Desktop Frame will host first-party and eventually third-party widgets on a shared surface that must look coherent, adopt the system appearance, and respect every accessibility setting ([DesignSystem](../Design/DesignSystem.md)). The codebase already defines geometry and motion constants (`AppConstants` in [Constants.swift](../../desktop-frame/Core/Utilities/Constants.swift)) and semantic colours ([Color+Extensions.swift](../../desktop-frame/Core/Extensions/Color+Extensions.swift)). The [ThemeSystem](../Architecture/ThemeSystem.md) distributes a theme at runtime. Prior-art research shows that naive open theming produces an incoherent desktop ([DesktopCustomizationUXResearch](../Research/DesktopCustomizationUXResearch.md), finding 2). We need a stated rule for how visual values are defined and consumed before the component library and any third-party theming are built.

## Problem

How should Desktop Frame define and expose visual values so that one definition restyles every surface, accessibility applies globally, and design and code never drift?

## Alternatives considered

1. **Literal values per view.** Each view sets its own colours/sizes. Simple to start; guarantees drift, breaks global theming and accessibility, and makes third-party coherence impossible. Rejected.
2. **Raw-value tokens (a palette of named hues/sizes, e.g. `blue500`, `space16`).** Centralises values but encodes *appearance* in the name; a widget asking for `blue500` is wrong in dark mode and high contrast. Rejected.
3. **Semantic-role tokens (chosen).** Tokens are roles (`accent`, `surface`, `space.m`, `motion.default`) resolved per appearance/accessibility by the theme; geometry/motion roles share the existing `AppConstants` values. Coherent, accessible by construction, versionable.

## Decision

Adopt **semantic-role design tokens** as the only sanctioned way to express visual values. Decided by the Product Designer with the Principal Engineer. Specifically: views and components reference semantic tokens, never literals; tokens for spacing/radius/motion are the same values as `AppConstants` (one source); colour/material/type roles resolve per appearance, contrast, Dynamic Type, and transparency at the theme layer ([ThemeSystem](../Architecture/ThemeSystem.md), [ADR-0003](ADR-0003-observable-state-model.md)); the token vocabulary is the contract that, when third-party theming opens, becomes public and versioned like the widget config schema ([ADR-0010](ADR-0010-widget-configuration-schema-versioning.md)). The full taxonomy is [DesignSystem](../Design/DesignSystem.md) and the reference is [DesignTokens](../Design/DesignTokens.md).

## Trade-offs

Semantic tokens constrain expressiveness — a widget or theme cannot use an arbitrary hue or a bespoke metric, and authors give up some freedom. Maintaining the role vocabulary and its resolutions is ongoing design work. We accept these for guaranteed coherence, accessibility-by-default, global restyling, and a tractable path to third-party theming.

## Consequences

- The component library is built entirely on tokens ([ComponentArchitecture](../Components/ComponentArchitecture.md)); hard-coded values fail design review ([DesignStandards](../Standards/DesignStandards.md)).
- Geometry/motion tokens must stay equal to `AppConstants`; a change touches code and design together (a future generator could enforce this).
- Accessibility settings resolve once, globally, through tokens — no per-widget handling ([AccessibilityDesign](../Design/AccessibilityDesign.md)).
- When third-party theming opens, this vocabulary is versioned; removing a role needs a deprecation cycle.

## References

1. [DesignSystem](../Design/DesignSystem.md) · [DesignTokens](../Design/DesignTokens.md) · [ThemeSystem](../Architecture/ThemeSystem.md) · [ADR-0010](ADR-0010-widget-configuration-schema-versioning.md).
2. Apple, "HIG — Foundations / Color / Materials." https://developer.apple.com/design/human-interface-guidelines/
