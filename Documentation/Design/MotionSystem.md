---
title: Motion system
status: Active
owner: Motion Design Lead
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [DesignSystem.md, DesignTokens.md, AccessibilityDesign.md, ../Architecture/RenderingEngine.md, ../Standards/PerformanceStandards.md]
---

# Motion system

How Desktop Frame moves: a small set of timing and spring tokens, used to communicate state and spatial relationships, never to decorate. Motion timing *is* the `AppConstants.Animation` the render loop already uses, so design and runtime share one source. This document owns the motion philosophy, the duration and spring tokens, the transition catalogue, the Reduce-Motion strategy, and the motion performance budget.

## Purpose and scope

In scope: motion principles, duration/spring tokens, the catalogue of standard transitions, Reduce Motion, and motion performance budgets. Out of scope: the render scheduler and GPU budget ([RenderingEngine](../Architecture/RenderingEngine.md)) and per-component micro-interactions ([Components](../Components/README.md)).

## Motion philosophy

- **Motion is meaning.** Every animation answers "what changed?" or "where did it come from / go to?". If it answers neither, it is removed ([principle 3](DesignPhilosophy.md)).
- **Quiet and quick.** Default motion is short and eased; nothing bounces, overshoots loudly, or loops to draw the eye. Springs are gently damped, not playful.
- **Physical, not flashy.** A dragged widget follows the cursor 1:1; a panel grows from where it was summoned. Motion reinforces direct manipulation ([ADR-0014](../Decisions/ADR-0014-direct-manipulation-widget-interaction-model.md)).
- **Honours Reduce Motion.** When the setting is on, meaningful motion collapses to an instant state change or a cross-fade; nothing essential is lost.

## Duration and spring tokens

The same constants the code ships ([Constants.swift](../../desktop-frame/Core/Utilities/Constants.swift)):

| Token | Value | Use |
|---|---|---|
| `motion.fast` | 0.15 s | Hover, selection, small state toggles, control feedback |
| `motion.default` | 0.30 s | The everyday transition: panels, sheets, widget add/remove |
| `motion.slow` | 0.60 s | Large or ambient changes: wallpaper transition, full-surface mode change |
| `motion.springResponse` | 0.40 | Spring response for direct-manipulation settle (snap, drop) |
| `motion.springDamping` | 0.82 | Spring damping — settles cleanly, minimal overshoot |

Easing: standard ease-in-out for property transitions; the spring (`response 0.40`, `damping 0.82`) for anything that follows or settles from a gesture, so snapping and dropping feel physical.

## Transition catalogue

| Transition | Token | Behaviour |
|---|---|---|
| Hover reveal (handles, toolbar) | `fast` | Fade/scale-in affordances on pointer enter; fade out on leave |
| Selection | `fast` | Accent ring + subtle lift appears |
| Widget add | `default` | Scale + fade up from the drop point |
| Widget remove | `default` | Scale + fade out in place |
| Widget snap / drop | spring | Settles to the grid position with the standard spring |
| Panel / inspector show | `default` | Grows/slides from its origin edge or trigger |
| Popover / context menu | `fast`–`default` | System-standard appearance from anchor |
| Sheet / dialog | `default` | Standard system sheet motion |
| Mode change (edit ↔ rest) | `default` | Chrome and grid fade in/out together |
| Wallpaper transition | `slow` | Cross-fade between wallpapers; power-aware ([WallpaperEngine](../Architecture/WallpaperEngine.md)) |
| Loading / progress | n/a | Determinate where possible; indeterminate uses the system spinner ([Components/StatesAndFeedback](../Components/StatesAndFeedback.md)) |

## Reduce Motion strategy

When **Reduce Motion** is on:

- Position/scale animations become an **instant change** or a short **cross-fade** (≤ `fast`).
- Springs are replaced by an immediate settle to the final position (snapping still happens, without the spring travel).
- Ambient/looping motion (animated wallpaper, ambient widget motion) pauses or holds a static frame; the user can still opt in per wallpaper ([WallpaperUX](../UX/WallpaperUX.md)).
- No information is conveyed only by motion; a state that animates also changes a static property ([AccessibilityDesign](AccessibilityDesign.md)).

This is resolved globally through the motion tokens, not re-decided per widget.

## Performance budgets

Motion lives inside the frame budget ([PerformanceStandards](../Standards/PerformanceStandards.md), [RenderingEngine](../Architecture/RenderingEngine.md)):

- Interactions and transitions hold the display's refresh rate (60 or 120 Hz); a dropped frame during a drag is a bug.
- Animate cheap properties (opacity, transform) — not layout, blur radius, or shadow, which force expensive recomposition.
- Only what is visible animates; off-screen and occluded surfaces do not run animations.
- Ambient motion is power- and visibility-aware: it slows or stops on battery, when occluded, or when the display sleeps.

## Accessibility

Reduce Motion is mandatory; meaningful-only motion means the reduced experience loses nothing essential. Focus and selection changes are also conveyed to VoiceOver, independent of their animation ([AccessibilityDesign](AccessibilityDesign.md)).

## Trade-offs

- Restrained, meaning-only motion forgoes the "wow" of richer animation; intentional, per the calm personality.
- Tying motion tokens to shipping constants means a timing change touches code and design together — the point, to avoid drift.

## Future evolution

A richer spring vocabulary (a second, livelier spring for optional "expressive" widgets) could extend the tokens additively. Interactive/scrubbable transitions (gesture-driven panel reveal) build on the same spring once direct manipulation matures.

## Open questions

- Whether the dragged-widget lift is shadow (elevation) or a subtle scale ([MaterialsAndElevation](MaterialsAndElevation.md) open question).
- The exact battery threshold at which ambient motion downgrades ([WallpaperEngine](../Architecture/WallpaperEngine.md)).

## References

1. [DesignTokens](DesignTokens.md) · [RenderingEngine](../Architecture/RenderingEngine.md) · [Constants.swift](../../desktop-frame/Core/Utilities/Constants.swift).
2. Apple, "HIG — Motion." https://developer.apple.com/design/human-interface-guidelines/motion

## Completion checklist
- [x] Motion principles, tokens, and transition catalogue defined.
- [x] Reduce Motion strategy and performance budget stated.
- [x] Tokens anchored to AppConstants.Animation.

## Review checklist
- [ ] Transition timings tuned against real interactions.
- [ ] Reconciled with RenderingEngine scheduler.
- [ ] Meets DocumentationStandards.
