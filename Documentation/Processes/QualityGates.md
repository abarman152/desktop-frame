---
title: Quality gates
status: Active
owner: Principal Engineer
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../../CLAUDE.md, ../Standards/PerformanceStandards.md, ../Standards/SecurityStandards.md, ../Standards/AccessibilityStandards.md, BugManagement.md]
---

# Quality gates

The mandatory checks a change clears before it is considered complete. The per-task review checklist is in [/CLAUDE.md](../../CLAUDE.md); this document defines the gates behind it and who enforces each.

## Purpose

Make "done" mean the same thing every time, so quality is a gate the work passes through rather than a judgment made case by case.

## Scope

Every change that reaches `main`. The depth of each gate scales with risk: a docs-only change clears the documentation and consistency gates and skips performance profiling; a change in the rendering hot path clears all of them.

## Ownership

The Principal Engineer owns the gate definitions. Each gate names an enforcing role. A gate is passed or it is not; there is no partial pass without a written, accepted exception.

## Inputs

- A change ready for review, with its tests and updated documentation.
- The performance, security, and accessibility standards.

## Outputs

- A change that has cleared every applicable gate, recorded in the pull request.
- Any accepted exception, written down with a reason and an owner.

## The gates

| Gate | The bar | Enforced by |
|---|---|---|
| Architecture | Fits accepted architecture, or an accepted ADR covers the change | Architect agent |
| Code quality | Builds with zero new warnings under strict concurrency; no forbidden practice; documented declarations | Reviewer |
| Testing | Unit and integration tests added or updated and passing; a bug fix has a failing-without-fix test | Testing agent |
| Performance | Within the budget in [../Standards/PerformanceStandards.md](../Standards/PerformanceStandards.md); measured if in a hot path | Performance agent |
| Security | Public APIs only; data stays on device unless opted in; permissions requested at point of use | Security agent |
| Accessibility | New interactive elements labeled; Reduce Motion and Reduce Transparency respected; per [../Standards/AccessibilityStandards.md](../Standards/AccessibilityStandards.md) | UI/UX agent |
| User experience | Matches the accepted spec and HIG; no regression in interaction | UI/UX agent |
| Documentation | Every affected doc updated in the same change; ADR written if architecture changed | Documentation agent |
| Maintainability | Small, single-purpose change; no dead code; names follow the standard | Reviewer |
| Consistency | Terminology, structure, and patterns match the rest of the codebase and docs | Reviewer |

## Required templates

A change that needed profiling attaches a [../Templates/PerformanceReport.md](../Templates/PerformanceReport.md). A change with security surface attaches a [../Templates/SecurityReview.md](../Templates/SecurityReview.md). Test evidence uses [../Templates/TestingReport.md](../Templates/TestingReport.md).

## Required reviews

At least one human or role approval that confirms every applicable gate. The performance and security gates require their owning agent's sign-off when the change touches their domain.

## Success criteria

No change reaches `main` with an unmet gate and no recorded exception. Exceptions are rare, time-boxed, and tracked to closure.

## KPIs

- Gate-escape rate: defects traced to a gate that should have caught them.
- Exception count and age: open exceptions and how long they stay open.
- Rework rate: changes sent back for a failed gate.

## Common failure cases

- Waving a change through under deadline pressure, which moves the cost to the next release at interest.
- Treating the gates as advisory. They are pass or fail.
- Granting an exception with no owner or expiry, so it becomes permanent.

## Best practices

- Run the gates continuously, not at the end. A change built to the gates rarely fails them.
- Automate what can be automated: build, tests, lint, and budget checks in CI, so human review focuses on judgment.
