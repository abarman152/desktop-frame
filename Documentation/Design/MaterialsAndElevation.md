---
title: Materials and elevation
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [DesignSystem.md, ColorSystem.md, DesignTokens.md, ../Architecture/ThemeSystem.md, AccessibilityDesign.md]
---

# Materials and elevation

How Desktop Frame builds depth: with **native materials** (system vibrancy and SwiftUI materials, Liquid Glass where available), corner radius, hairline borders, and restrained shadow — never hand-rolled translucency. Material is the default surface look; elevation tells the user what floats above what. This document owns the material levels, radius, borders, shadow, and the elevation model. The decision to use native materials is [ADR-0013](../Decisions/ADR-0013-native-materials-over-custom-translucency.md).

## Purpose and scope

In scope: material levels (glass/blur/opaque), opacity behaviour, corner radius, borders, shadow, and elevation layering. Out of scope: colour roles ([ColorSystem](ColorSystem.md)) and window levels ([WindowSystem](../Architecture/WindowSystem.md)).

## Design principles

- **Materials are native.** Surfaces use `NSVisualEffectView` / SwiftUI `Material`, adopting the platform's vibrancy and its Liquid Glass direction — so Desktop Frame matches macOS exactly and inherits its future for free ([ADR-0013](../Decisions/ADR-0013-native-materials-over-custom-translucency.md)).
- **Depth is honest and shallow.** The surface has few elevation levels; chrome floats just enough to read as above content, never with a heavy drop shadow ([principle 2](DesignPhilosophy.md)).
- **Material has a legible fallback.** Under Reduce Transparency every material resolves to an opaque colour with the same role ([AccessibilityDesign](AccessibilityDesign.md)).

## Material levels

| Token | Material | Use |
|---|---|---|
| `glass` | Standard window/HUD vibrancy (`.regularMaterial` / `NSVisualEffectView`) | Default widget and panel surface; the everyday look |
| `blur` | Heavier material (`.thickMaterial` / hud-window) | Overlays, the Dashboard, popovers needing more separation from busy content |
| `opaque` | Solid `surface` colour, no vibrancy | Reduce-Transparency fallback; dense content where vibrancy hurts legibility |

Material is a token a surface asks for; the [ThemeSystem](../Architecture/ThemeSystem.md) supplies the concrete effect. A widget never composes its own blur.

## Opacity and tint

The material carries the translucency; the colour layer on top is near-opaque so text and controls stay crisp over any wallpaper. The existing `widgetBackground` (`windowBackgroundColor` at `0.6`) is exactly this pattern: a tinted, mostly-opaque fill *over* the vibrancy, not a faked blur. Opacity values are tokens, not arbitrary ([ColorSystem](ColorSystem.md) "opacity rules").

## Corner radius

| Token | Value | Use |
|---|---|---|
| `card` | 16 | Widgets, panels, cards (`Window.defaultCornerRadius = 16`) |
| `control` | 8 | Buttons, fields, segmented controls, small chips |
| `pill` | height/2 | Fully rounded toggles, tags |

Radius is continuous-corner (squircle) to match macOS. The `card`/`control` values are anchored to the shipping `defaultCornerRadius` and the 8-pt grid.

## Borders

Borders are hairlines, used only where a material edge needs definition against busy wallpaper — the existing `widgetBorder` (`separatorColor` at `0.4`). Interactive surfaces gain a slightly stronger border on hover/selection; focus uses the accent ring, not a border thickness change ([UX/InteractionModel](../UX/InteractionModel.md)).

## Elevation model

Four levels, low to high. Elevation is expressed primarily by **material and a soft shadow**, not by large offsets:

| Level | What sits here | Treatment |
|---|---|---|
| 0 — surface | The desktop canvas / wallpaper | No shadow; the backdrop |
| 1 — resting | Widgets on the canvas | `glass`, hairline border, no/!minimal shadow |
| 2 — floating | Toolbars, inspector, selected/dragged widget | `glass`, soft short shadow; lifts on interaction |
| 3 — modal | Popovers, sheets, dialogs, the Dashboard | `blur`, slightly larger soft shadow; system-owned where possible |

Window *levels* (which OS layer a surface lives on) are a separate concern owned by [WindowSystem](../Architecture/WindowSystem.md); elevation here is the *visual* language within a level.

## Accessibility

Under **Reduce Transparency**, `glass`/`blur` resolve to `opaque` with the role colour, preserving contrast; under **Increase Contrast**, borders strengthen and shadows may be replaced by a defined edge. Depth never carries meaning that is lost without it — a floating panel also differs by position and border ([AccessibilityDesign](AccessibilityDesign.md)).

## Performance

Vibrancy and shadow are GPU costs. Budgets ([PerformanceStandards](../Standards/PerformanceStandards.md), [RenderingEngine](../Architecture/RenderingEngine.md)): materials are used at the surface/panel level, not nested deeply; shadows are soft but small-radius (cheaper); blur layers are minimised and never animated per frame. A widget that stacks multiple vibrancy layers is a performance bug.

## Trade-offs

- Native materials mean less control over the exact look, and a dependency on platform behaviour changing under us — accepted for the native feel and the maintenance saving ([ADR-0013](../Decisions/ADR-0013-native-materials-over-custom-translucency.md)).
- A shallow elevation model limits dramatic depth effects; intentional, per restraint.

## Future evolution

As Liquid Glass APIs mature, `glass`/`blur` map onto them directly with no change to widget code (the point of tokenising material). A future depth/elevation token group could add richer compositing for premium widgets without breaking existing ones ([DesignSystem](DesignSystem.md) future evolution).

## Open questions

- Whether the dragged-widget lift should be level 2 shadow or a subtle scale, pending motion review ([MotionSystem](MotionSystem.md)).

## References

1. [ADR-0013](../Decisions/ADR-0013-native-materials-over-custom-translucency.md) · [ThemeSystem](../Architecture/ThemeSystem.md) · [RenderingEngine](../Architecture/RenderingEngine.md).
2. Apple, "HIG — Materials." https://developer.apple.com/design/human-interface-guidelines/materials
3. Apple, "NSVisualEffectView." https://developer.apple.com/documentation/appkit/nsvisualeffectview

## Completion checklist
- [x] Material levels, radius, borders, shadow defined.
- [x] Elevation model and Reduce-Transparency fallback specified.
- [x] Performance budget for materials stated.

## Review checklist
- [ ] Reconciled with ThemeSystem material tokens and RenderingEngine budget.
- [ ] Liquid Glass mapping verified on target OS.
- [ ] Meets DocumentationStandards.
