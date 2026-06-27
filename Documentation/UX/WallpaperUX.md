---
title: Wallpaper UX
status: Active
owner: UI/UX
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [README.md, ../Components/Navigation.md, ../Architecture/WallpaperEngine.md, ../Design/MotionSystem.md, ../Standards/PerformanceStandards.md]
---

# Wallpaper UX

The experience of choosing and living with a wallpaper across its types — static image, dynamic (time/appearance-reactive), video, shader, and interactive. It is the experience layer over the [WallpaperEngine](../Architecture/WallpaperEngine.md) and is held tightly to the performance budget, because the wallpaper runs continuously behind everything ([PerformanceStandards](../Standards/PerformanceStandards.md)).

## Purpose and scope

In scope: the picker, categories, preview, crop/scale, transitions, and the per-type experience and its power/perf trade-offs. Out of scope: the rendering pipeline and power-aware lifecycle internals ([WallpaperEngine](../Architecture/WallpaperEngine.md), [ADR-0006](../Decisions/ADR-0006-tiered-rendering-strategy.md)).

## Design principles

- **The wallpaper is the user's content** ([principle 2](../Design/DesignPhilosophy.md)): the chrome to manage it is quiet and gets out of the way; the wallpaper itself is the star.
- **Preview before commit, revert always available:** choosing is live and reversible.
- **Honest about cost:** richer wallpaper types disclose their power/performance impact so the choice is informed.

## The picker

A categorised, searchable gallery ([Components/Navigation](../Components/Navigation.md) Wallpaper Selector): **Static, Dynamic, Video, Shader, Interactive**, plus the user's own imports and (future) the marketplace. Thumbnails are lazy-loaded and downscaled; selecting one previews it live on the actual desktop (the truest preview) with an obvious **Revert**. Per-display selection is supported — each display can have its own wallpaper ([MultiMonitorArchitecture](../Architecture/MultiMonitorArchitecture.md)).

## Per-type experience

| Type | Experience | Cost disclosure |
|---|---|---|
| Static image | Pick, crop, scale; instant | None |
| Dynamic | Reacts to time of day / light-dark; preview shows the variants | Low |
| Video | Loops; user sets fit and whether it plays on battery | Medium — flagged; pauses when occluded/battery |
| Shader | Generative/animated; parameters where the author exposes them | Medium–high — flagged; power-aware |
| Interactive | Responds to cursor/system state | Higher — flagged; degrades when occluded/battery |

Richer types show an estimated impact and respect the power-aware lifecycle: animation pauses when fully occluded, the display sleeps, or the machine is on low battery ([WallpaperEngine](../Architecture/WallpaperEngine.md)). The user can cap this in Settings → Performance ([SettingsUX](SettingsUX.md)).

## Crop, scale, fit

Imported images get crop and fit (fill / fit / centre / tile) with a live preview at the display's aspect; multi-display and Retina scaling are handled so the image is crisp and uncropped where intended ([LayoutAndSpacing](../Design/LayoutAndSpacing.md)). Video/shader get a fit mode, not a crop.

## Transitions

Switching wallpaper cross-fades over `motion.slow` ([MotionSystem](../Design/MotionSystem.md)); Reduce Motion replaces the cross-fade with an instant swap. Dynamic wallpapers transition between their variants smoothly and cheaply. No transition blocks interaction.

## Accessibility

The picker is fully keyboard/VoiceOver operable (labelled thumbnails, not preview-only); Reduce Motion stills animated types or holds a static frame, with a per-wallpaper opt-in ([MotionSystem](../Design/MotionSystem.md)); Reduce Transparency does not affect wallpaper but ensures widget surfaces above stay legible ([MaterialsAndElevation](../Design/MaterialsAndElevation.md)); a wallpaper is never the sole carrier of information.

## Performance

This is the budget-critical surface ([RenderingEngine](../Architecture/RenderingEngine.md), [ADR-0006](../Decisions/ADR-0006-tiered-rendering-strategy.md)): previews are downscaled; only the active wallpaper renders; animated types are visibility- and power-aware; a wallpaper that cannot hold the budget falls back to a static frame rather than dropping frames. Cost is disclosed at choice time.

## Trade-offs

- Allowing video/shader/interactive wallpaper invites performance and battery cost; mitigated by disclosure, power-awareness, and a Settings cap, and bounded by the tiered rendering budget.
- Live full-desktop preview is the truest preview but briefly changes the user's actual wallpaper; Revert and non-destructive apply make it safe.

## Future evolution

A wallpaper marketplace and author-tunable shader parameters; scheduled/automatic wallpaper rotation; per-Space wallpaper. All reuse the picker and the power-aware lifecycle.

## Open questions

- Default play-on-battery behaviour for video/shader (off by default vs user-set on first use).
- Whether interactive wallpaper ships in v1 or follows static/dynamic/video.

## References

1. [WallpaperEngine](../Architecture/WallpaperEngine.md) · [ADR-0006](../Decisions/ADR-0006-tiered-rendering-strategy.md) · [MotionSystem](../Design/MotionSystem.md) · [PerformanceStandards](../Standards/PerformanceStandards.md).
2. Apple, "HIG — Materials / Motion." https://developer.apple.com/design/human-interface-guidelines/

## Completion checklist
- [x] Picker, per-type experience, crop/scale, and transitions specified.
- [x] Cost disclosure and power-aware behaviour stated.
- [x] Accessibility and performance covered.

## Review checklist
- [ ] Reconciled with WallpaperEngine lifecycle and the rendering budget.
- [ ] Reduce Motion behaviour verified per wallpaper type.
- [ ] Meets DocumentationStandards.
