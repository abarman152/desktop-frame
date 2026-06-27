---
title: <feature> UI specification
status: Draft
owner: UI/UX
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
related: []
---

<!--
TEMPLATE: UI specification. Copy to Documentation/Design/. Follows
../Standards/DocumentationStandards.md and the HIG notes. Specifies interaction
and motion the SwiftUI role implements.
-->

# <feature> UI specification

## Overview

What the user does with this feature and the experience goal.

## Layout and states

The layout, the states (empty, loading, populated, error), and how it adapts to light and dark and to window and display size.

## Interaction

Every interaction: input, result, and feedback. Keyboard and pointer behavior. Conformance to macOS conventions.

## Motion

Transitions and animation, with their meaning. Reduce Motion behavior.

## Accessibility

Labels, focus order, and Reduce Transparency behavior, per ../Standards/AccessibilityStandards.md.

## Design tokens

The colors, type, spacing, and materials used, from the design system. No hard-coded values.

## Completion checklist
- [ ] All states and adaptations specified.
- [ ] Every interaction has defined feedback.
- [ ] Motion and Reduce Motion behavior defined.
- [ ] Accessibility specified.

## Review checklist
- [ ] HIG-compliant; defers to content; calm.
- [ ] Implementable without guessing.
- [ ] Meets DocumentationStandards.
