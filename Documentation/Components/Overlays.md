---
title: Overlays
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [ComponentArchitecture.md, README.md, ../Design/MotionSystem.md, ../UX/InteractionModel.md, StatesAndFeedback.md]
---

# Overlays

The transient and modal surfaces: dialogs, sheets, popovers, the notification banner, and progress indicators. They interrupt or supplement the surface briefly, so they are held tightly to macOS conventions and to "inform from the periphery" ([principle 3](../Design/DesignPhilosophy.md)). Shared state/variant meaning is in [ComponentArchitecture](ComponentArchitecture.md).

## Purpose and scope

In scope: the five overlay components and their behaviour. Out of scope: the empty/error content they may host ([StatesAndFeedback](StatesAndFeedback.md)) and focus mechanics in depth ([UX/InteractionModel](../UX/InteractionModel.md)).

## Dialog

- **Purpose.** A blocking decision the user must make (confirm a destructive action, resolve a conflict).
- **Variants.** Standard (message + buttons) · Destructive (danger primary) · With suppression ("don't ask again").
- **States.** Presenting · Visible · Dismissing.
- **Accessibility.** Traps focus; default and cancel mapped to Return/Escape; message is the accessible label.
- **Keyboard.** Return = default, Escape = cancel; full keyboard.
- **Animation.** System dialog motion (`motion.default`); Reduce Motion → fade.
- **Guidelines.** Used sparingly — prefer undo over a confirm. Destructive dialogs name the consequence and the count ([principle: reversible by default](../Design/DesignPhilosophy.md)).

## Sheet

- **Purpose.** A modal task attached to a window (multi-step config, import, first-run a widget).
- **Variants.** Single-step · Multi-step (with progress) · Form.
- **States.** Presenting · Editing · Validating · Dismissing.
- **Sizing.** Content-sized within the host window; built on Glass Panel.
- **Accessibility.** Focus trapped to the sheet; logical order; clear cancel/commit.
- **Keyboard.** Escape cancels; Return commits when valid; Tab through fields.
- **Animation.** Standard sheet slide (`motion.default`).
- **Guidelines.** For a focused task tied to a window; for a brief contextual choice use a Popover instead.

## Popover

- **Purpose.** A transient, non-modal surface anchored to a control (quick config, a detail, a small picker).
- **Variants.** Transient (dismiss on outside click) · Semi-transient · With arrow to anchor.
- **States.** Presenting · Visible · Dismissing.
- **Sizing.** Compact, content-sized; `blur` material; arrow points to the anchor.
- **Accessibility.** Moves focus in on open, restores on close; Escape dismisses.
- **Keyboard.** Opens from its control; Escape closes; does not block the rest of the UI.
- **Animation.** `motion.fast`–`default` from the anchor.
- **Guidelines.** The default for lightweight, anchored interactions; never use for a long task (use a Sheet).

## Notification Banner

- **Purpose.** A quiet, dismissible in-app message (update available, plugin installed, a recoverable error).
- **Variants.** Info · Success · Warning · Error (each with role colour + icon, never colour alone).
- **States.** Appearing · Visible · Auto-dismissing · Dismissed · With action.
- **Sizing.** Compact; top or corner; does not cover content it refers to.
- **Accessibility.** Announced to VoiceOver politely (not assertively unless urgent); dismiss and action are keyboard-reachable; never relies on colour.
- **Keyboard.** Focusable; Escape dismisses; action reachable.
- **Animation.** `motion.fast` in/out; Reduce Motion → fade.
- **Guidelines.** Quiet and brief; an action banner persists until acted on or dismissed; informational banners auto-dismiss. Honours "inform from the periphery" — no banner demands attention it did not earn.

## Progress Indicators

- **Purpose.** Show that work is happening, and how much remains.
- **Variants.** Determinate (bar/ring with %) · Indeterminate (system spinner) · Inline (in a button/card).
- **States.** Idle · Running · Complete · Failed (→ error state).
- **Accessibility.** Determinate exposes value; indeterminate exposes a busy state; paired with a text label.
- **Animation.** System spinner timing; determinate updates smoothly without relayout.
- **Performance.** Indeterminate spinners are cheap; determinate avoids per-frame layout ([MotionSystem](../Design/MotionSystem.md)).
- **Guidelines.** Prefer determinate when progress is knowable; never show a spinner for instant operations ([StatesAndFeedback](StatesAndFeedback.md) loading patterns).

## Trade-offs

- Preferring popovers/undo over dialogs reduces interruption but means fewer hard confirmations; accepted, with destructive actions as the exception that still confirms.
- Quiet banners may be missed by users expecting loud alerts; intentional, per the calm personality, with persistence for anything actionable.

## Future evolution

A unified, queued notification surface (grouping multiple banners) and a richer multi-step sheet framework as flows grow ([UX/UserFlows](../UX/UserFlows.md)). Plugin-originated notifications route through the same banner with author attribution and rate limits ([PluginSDK](../Architecture/PluginSDK.md)).

## Open questions

- Default auto-dismiss timing for informational banners.

## References

1. [ComponentArchitecture](ComponentArchitecture.md) · [MotionSystem](../Design/MotionSystem.md) · [StatesAndFeedback](StatesAndFeedback.md).
2. Apple, "HIG — Alerts / Sheets / Popovers." https://developer.apple.com/design/human-interface-guidelines/components

## Completion checklist
- [x] Five overlay components specified against the schema.
- [x] Focus, keyboard, and Reduce-Motion behaviour stated.
- [x] Quiet-notification and prefer-undo rules noted.

## Review checklist
- [ ] Reconciled with InteractionModel focus management.
- [ ] Banner urgency levels verified with VoiceOver.
- [ ] Meets DocumentationStandards.
