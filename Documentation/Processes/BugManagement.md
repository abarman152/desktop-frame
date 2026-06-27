---
title: Bug management
status: Active
owner: QA Lead
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [IncidentManagement.md, QualityGates.md, ../Templates/BugReport.md, ../Templates/RootCauseAnalysis.md]
---

# Bug management

The lifecycle of a defect from report to verified fix. Tracking lives in the Notion Bug Tracker; this document defines the process.

## Purpose

Ensure every defect is captured, triaged, fixed at the right priority, and verified, so quality is managed rather than hoped for.

## Scope

All defects in shipped or in-development Desktop Frame code. A defect severe enough to affect users in production also triggers [IncidentManagement.md](IncidentManagement.md); the two run in parallel for those cases.

## Ownership

The QA Lead owns the lifecycle. The assignee owns the fix. The reporter owns enough detail to reproduce.

## Inputs

- A bug report (from a user, a contributor, or a failing test) using [../Templates/BugReport.md](../Templates/BugReport.md).
- The macOS version, hardware, and build where it occurred.

## Outputs

- A triaged, prioritized Bug Tracker entry.
- A fix with a regression test.
- A verification record.
- For High and Critical bugs, a root cause analysis using [../Templates/RootCauseAnalysis.md](../Templates/RootCauseAnalysis.md).

## Workflow

1. Report. Capture the bug with reproduction steps, expected versus actual behavior, environment, and reproducibility.
2. Triage. Assign severity and priority (below). Confirm or close as not-reproducible.
3. Diagnose. Find the root cause, not the symptom. For High and Critical, write a root cause analysis.
4. Fix. On a `fix/` branch, add a test that fails without the fix, then fix it. See [GitWorkflow.md](GitWorkflow.md).
5. Verify. QA confirms the fix against the original reproduction on the affected environment, and checks for regressions.
6. Close. Record the fixing build and version.

### Severity

How bad the impact is, independent of how often it happens.

| Severity | Meaning |
|---|---|
| Critical | Data loss, crash on launch, or the Mac is harmed (runaway CPU, battery drain) |
| High | A core feature is broken with no workaround |
| Medium | A feature is impaired but has a workaround |
| Low | Cosmetic or minor, no functional impact |

### Priority

When it gets fixed, from severity and frequency together: Critical, High, Medium, Low. A Critical-severity bug that always reproduces is the highest priority and blocks release.

### Verification checklist

- [ ] Original reproduction no longer reproduces.
- [ ] A regression test exists and fails without the fix.
- [ ] No new warnings or budget regressions introduced.
- [ ] Adjacent functionality re-checked for side effects.

## Required templates

- [../Templates/BugReport.md](../Templates/BugReport.md)
- [../Templates/RootCauseAnalysis.md](../Templates/RootCauseAnalysis.md)
- [../Templates/IncidentReport.md](../Templates/IncidentReport.md) for production-affecting defects.

## Required reviews

A fix is reviewed like any change, against the [/CLAUDE.md](../../CLAUDE.md) review checklist. The root cause analysis for Critical bugs is reviewed by the Principal Engineer.

## Success criteria

Every Critical and High bug has a root cause and a regression test. No bug is closed without verification on the affected environment.

## KPIs

- Time to triage and time to fix, by severity.
- Reopen rate: bugs that failed verification or recurred.
- Regression rate: new bugs introduced by fixes.
- Escaped defects per release.

## Common failure cases

- Fixing the symptom and leaving the root cause, so the bug returns in another form.
- Closing without a regression test, guaranteeing eventual recurrence.
- Verifying on a different environment than the report, missing the actual condition.
- Severity inflation or deflation that distorts the queue.

## Best practices

- Reproduce before fixing. A fix for a bug you cannot reproduce is a guess.
- Write the failing test first; it proves the bug and then proves the fix.
- For recurring classes of bug, fix the class, not just the instance, and record it as an ADR or a standard.
