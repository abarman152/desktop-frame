---
title: States and feedback
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [ComponentArchitecture.md, Overlays.md, ../UX/UserFlows.md, ../Design/Iconography.md, ../Design/AccessibilityDesign.md]
---

# States and feedback

The non-happy-path surfaces, designed as carefully as the happy one: empty states, loading states, error states, skeleton loaders, and the onboarding components. They are where a product feels considered or careless ([principle: accessible/calm by default](../Design/DesignPhilosophy.md)). The shared state vocabulary is in [ComponentArchitecture](ComponentArchitecture.md); this doc specifies the patterns.

## Purpose and scope

In scope: empty/loading/error/skeleton patterns and onboarding components. Out of scope: the flows that string them together ([UX/UserFlows](../UX/UserFlows.md)) and overlay mechanics ([Overlays](Overlays.md)).

## Empty State

- **Purpose.** Communicate "nothing here yet" and the single next step.
- **Variants.** First-use (no widgets) · No-results (search) · No-data (permission-needed) · All-done (reminders).
- **Anatomy.** Quiet line illustration ([Iconography](../Design/Iconography.md)) · one-line explanation · one primary action.
- **States.** Static; the action leads onward.
- **Accessibility.** Illustration hidden from assistive tech; the explanation and action carry the meaning; action keyboard-reachable.
- **Guidelines.** Exactly one next step; never a dead end; tone is calm and helpful, not jokey. Permission-needed empties explain *why* and link to grant.

## Loading State

- **Purpose.** Show that content is coming without blocking or flashing.
- **Variants.** Skeleton (preferred for structured content) · Inline spinner (small/unknown shape) · Determinate progress (known length, → [Overlays](Overlays.md)).
- **States.** Loading · Loaded (cross-fade in) · Slow (after a threshold, reassure) · Failed (→ error).
- **Accessibility.** Exposes a busy state; does not spam announcements; the loaded content takes focus appropriately.
- **Animation.** Skeleton shimmer is subtle and slow; content cross-fades in `motion.fast`; Reduce Motion → static placeholder then fade.
- **Performance.** Skeletons are cheap static shapes; spinners are the system indicator; no heavy placeholder.
- **Guidelines.** Use a skeleton when the layout is known (it prevents layout shift); a spinner only when shape is unknown; never a spinner for instant work.

## Skeleton Loader

- **Purpose.** A placeholder mirroring the real content's layout while it loads.
- **Variants.** Card skeleton · List-row skeleton · Chart skeleton.
- **Anatomy.** Token-coloured (`surfaceSecondary`) blocks at the real content's positions; optional subtle shimmer.
- **Accessibility.** Marked as a loading placeholder, not read as content; shimmer respects Reduce Motion.
- **Guidelines.** Match the real layout so the transition is seamless; do not animate aggressively.

## Error State

- **Purpose.** Explain what went wrong and how to recover ([UX/UserFlows](../UX/UserFlows.md) recovery).
- **Variants.** Inline (within a card) · Banner (transient, → [Overlays](Overlays.md)) · Full-surface (rare).
- **Anatomy.** `danger` icon + label (never colour alone) · plain-language cause · a recovery action (retry/settings).
- **States.** Error · Retrying · Recovered.
- **Accessibility.** Announced; cause and action are text; action keyboard-reachable; not colour-dependent.
- **Guidelines.** Plain language, no codes-only; always offer a next step; preserve the user's data and context across the error.

## Onboarding Components

- **Purpose.** Get a first-run user to a configured surface quickly, then get out of the way ([UX/UserFlows](../UX/UserFlows.md) onboarding).
- **Variants.** Welcome panel · Permission primer (before a system prompt) · Coach mark / inline tip · Sample-layout offer.
- **States.** Step n of m · Skipped · Completed · Re-openable from Help.
- **Sizing.** A sheet or panel ([Overlays](Overlays.md)); minimal steps.
- **Accessibility.** Fully keyboard/VoiceOver operable; skippable; focus managed across steps.
- **Animation.** `motion.default` between steps; Reduce Motion → instant.
- **Guidelines.** Short, skippable, and value-first (show a configured desktop fast); explain *why* before each permission prompt so grant rates are honest, not tricked. Onboarding is the one place a brief, quiet delight moment is allowed ([DesignPhilosophy](../Design/DesignPhilosophy.md) open question).

## Trade-offs

- Designing every non-happy state costs effort up front; it is what separates a considered product from a fragile one, and is required for the quality bar.
- Skeletons add layout-mirroring work versus a single spinner; the payoff is no layout shift and a calmer load.

## Future evolution

A reusable empty/error/loading toolkit so every new feature and third-party widget gets considered states for free; onboarding becomes contextual (just-in-time tips) rather than front-loaded as the product grows.

## Open questions

- How much front-loaded onboarding versus just-in-time guidance the first-run flow should use ([UX/UserFlows](../UX/UserFlows.md)).

## References

1. [ComponentArchitecture](ComponentArchitecture.md) · [Overlays](Overlays.md) · [UX/UserFlows](../UX/UserFlows.md) · [AccessibilityDesign](../Design/AccessibilityDesign.md).
2. Apple, "HIG — Loading / Onboarding / Feedback." https://developer.apple.com/design/human-interface-guidelines/

## Completion checklist
- [x] Empty/loading/skeleton/error/onboarding patterns specified.
- [x] One-next-step, plain-language, and Reduce-Motion rules stated.
- [x] Accessibility per pattern covered.

## Review checklist
- [ ] Reconciled with UserFlows recovery and onboarding strategy.
- [ ] Verified with VoiceOver and Reduce Motion.
- [ ] Meets DocumentationStandards.
