---
title: Design philosophy
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [DesignSystem.md, README.md, ../../CLAUDE.md, ../Research/MacOSPlatformResearch.md, ../UX/InteractionModel.md]
---

# Design philosophy

The beliefs that decide every visual and interaction choice in Desktop Frame, before any token or component exists. The product's identity — vision, mission, principles — is owned in Notion ([Product Philosophy](https://app.notion.com/p/38bc634e2df681e79944c1d1ec5cd45f), [Core Principles](https://app.notion.com/p/38bc634e2df681e5a2daf9407923d8c0)); this document is the *design* expression of that identity: how those principles look, move, and feel. When a design question has no obvious answer, the order of principles below resolves it.

## Purpose and scope

In scope: the design principles, the product's visual personality, the interaction philosophy, and the decision rules a designer or engineer uses to break a tie. Out of scope: the token values ([DesignSystem](DesignSystem.md)), the component specifications ([Components](../Components/README.md)), and product strategy (Notion).

## Core design principles

Conflict-ordered — when two principles pull in opposite directions, the earlier one wins. This mirrors the constitution's conflict-ordered [Core Principles](https://app.notion.com/p/38bc634e2df681e5a2daf9407923d8c0).

1. **The Mac comes first.** Desktop Frame looks and behaves like it shipped with macOS. Native materials, SF Symbols, system accent, standard controls, standard keyboard and trackpad conventions. Familiarity beats novelty for anything a user does often ([MacOSPlatformResearch](../Research/MacOSPlatformResearch.md)).
2. **Defer to the user's content.** The surface frames the user's wallpaper, widgets, and work; it never competes with them. Chrome is quiet, restrained, and recedes when not in use. This is Apple's *deference* applied to a product whose entire job is to be the backdrop.
3. **Inform from the periphery.** A widget earns a glance, not a stare. Information is calm and ambient; nothing animates, badges, or colours itself to demand attention it did not earn.
4. **Default to less.** Every surface ships with the smallest set of controls that does the job. Power lives one disclosure deeper, never on the first screen ([UX/InformationArchitecture](../UX/InformationArchitecture.md)).
5. **Configurable without code.** Customisation is a first-class design goal: a user reshapes the surface by direct manipulation and settings, never by editing a file. The design system is what makes deep customisation still look coherent.
6. **Consistency is a feature.** A button, a card, a label look and behave the same everywhere, because they come from the same tokens and component specs. Consistency is what lets third-party widgets feel native.
7. **Performance is a design constraint.** A design that cannot hold 60–120 fps within the [performance budget](../Standards/PerformanceStandards.md) is not a finished design. Motion, blur, and shadow are chosen with their cost in mind.
8. **Accessible by default.** A design is done when it works with VoiceOver, full keyboard control, Reduce Motion, Reduce Transparency, Increase Contrast, and Dynamic Type — not after ([AccessibilityDesign](AccessibilityDesign.md)).

## Visual identity and personality

Desktop Frame's personality is **calm, precise, and deferential** — a quiet instrument, not a toy. The visual identity is carried almost entirely by the platform: system materials, the user's own accent colour, SF Symbols, and standard type. The product's own brand expression is deliberately minimal — a refined wordmark and app icon — because the surface belongs to the user's content, not to Desktop Frame. Where the product does express itself, it is through *craft*: precise spacing, honest materials, motion that means something, and details that reward a second look without asking for one.

Three adjectives govern any judgement call: **native** (does it belong on macOS?), **quiet** (does it recede?), **precise** (is it built to Apple's quality bar?).

## Interaction philosophy

- **Direct manipulation first.** A user moves a widget by dragging it, resizes it by its edge, and sees the result instantly ([ADR-0014](../Decisions/ADR-0014-direct-manipulation-widget-interaction-model.md)). Indirection (dialogs, modes) is a last resort.
- **The surface is calm at rest.** Editing affordances (handles, grids, toolbars) appear on intent — hover, selection, an explicit edit mode — and disappear when the user is done ([UX/InteractionModel](../UX/InteractionModel.md)).
- **Reversible by default.** Every manipulation is undoable; the design never relies on a confirming dialog where undo would do.
- **Motion is meaning.** Animation communicates a state change or a spatial relationship; it is never decoration. Under Reduce Motion it collapses to an instant, legible change ([MotionSystem](MotionSystem.md)).

## Delight, without noise

Delight in Desktop Frame is the absence of friction and the presence of craft, not surprise. It is a widget that snaps cleanly to the grid, a panel whose material matches the system exactly, a transition that feels physical. Delight that demands attention (bouncing, confetti, sound) violates principles 2 and 3 and is not used.

## Decision rules (how to break a tie)

When a choice is genuinely open, apply these in order:

1. Does one option match a macOS convention the user already knows? Choose it.
2. Does one option defer more to the user's content (quieter, less chrome)? Choose it.
3. Does one option remove a control from the default surface? Choose it.
4. Does one option cost less performance for the same outcome? Choose it.
5. Still tied? It is a product decision — log it in the [Decision Log](https://app.notion.com/p/38bc634e2df681d0b31eeb1112f3741c), and if it is architectural, write an [ADR](../Decisions/README.md).

## Trade-offs this philosophy accepts

- **Familiarity over differentiation.** Leaning on native conventions means Desktop Frame looks less "branded" than competitors. That is intentional: the surface should disappear, and a native feel is the moat.
- **Restraint over richness.** "Default to less" means some power-user features are deliberately one disclosure deep, costing discoverability for the sake of a calm first screen ([UX/InformationArchitecture](../UX/InformationArchitecture.md)).
- **Consistency over per-widget expression.** Token-driven design constrains how different a widget can look. A third-party author gives up some freedom in exchange for looking native for free ([ThemeArchitecture](ThemeArchitecture.md)).

## Future evolution

As the platform opens to third parties, this philosophy becomes the contract authors design against: the principles below are what a marketplace review checks a widget against. The personality may gain a richer brand expression in marketing surfaces (the marketplace, onboarding) while the in-surface restraint stays fixed.

## Open questions

- How much built-in theming expressiveness to offer before third-party theming opens, without diluting "defer to content".
- Whether a light "first-run delight" moment is worth a one-time exception to principle 3.

## References

1. [DesignSystem](DesignSystem.md) · [MotionSystem](MotionSystem.md) · [AccessibilityDesign](AccessibilityDesign.md) · [ADR-0014](../Decisions/ADR-0014-direct-manipulation-widget-interaction-model.md).
2. Apple, "Human Interface Guidelines — macOS." https://developer.apple.com/design/human-interface-guidelines/designing-for-macos
3. Apple, "Human Interface Guidelines — Foundations / Right to left." https://developer.apple.com/design/human-interface-guidelines/

## Completion checklist
- [x] Principles stated and conflict-ordered.
- [x] Personality and interaction philosophy defined.
- [x] Decision rules and accepted trade-offs named.

## Review checklist
- [ ] Consistent with Notion Product Philosophy and Core Principles.
- [ ] Reconciled with the UI/UX agent role.
- [ ] Meets DocumentationStandards.
