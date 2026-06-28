---
title: Accessibility standards
status: Active
owner: UI/UX
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../Processes/QualityGates.md, ../../.agents/UI_UX_AGENT.md, ../Design/AccessibilityDesign.md, DesignStandards.md]
---

# Accessibility standards

Desktop Frame is usable by everyone, on the same release as everyone else. Accessibility is part of the definition of done, not a later pass. The project's `ios-accessibility` skill carries the implementation patterns and [Design/AccessibilityDesign](../Design/AccessibilityDesign.md) carries the design-side patterns; this standard sets the bar.

## Requirements

- Every interactive element has an accessibility label, and a hint where the action is not obvious.
- Decorative elements are hidden from assistive technologies.
- Reading and focus order is logical and matches the visual order.
- The app honors Reduce Motion: meaningful motion only, and a reduced alternative when the setting is on.
- The app honors Reduce Transparency: legible fallbacks for glass and vibrancy.
- Full keyboard operability: every action reachable without a pointer, with visible focus.
- VoiceOver navigates the whole experience coherently.
- Dynamic Type and scaled metrics where text is shown, so sizing respects user preference.
- Color is never the only carrier of meaning; contrast meets the platform guidance.

## Enforcement

The accessibility gate in [QualityGates.md](../Processes/QualityGates.md), owned by the UI/UX agent, confirms these for every change that adds or alters interface. New interactive elements without labels do not pass.

## Verification

- VoiceOver walkthrough of new or changed interface.
- Full-keyboard pass with visible focus.
- Toggle Reduce Motion and Reduce Transparency and confirm the fallbacks.
- Where automated accessibility checks exist (XCTest), they run in CI.

## Common gaps

- Unlabeled icon-only buttons.
- Focus order that jumps around because the view tree does not match the visual layout.
- Glass effects with no legible fallback under Reduce Transparency.
- Motion with no reduced alternative.
