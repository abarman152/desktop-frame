---
title: Sprint management
status: Active
owner: Engineering Manager
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [ProjectLifecycle.md, QualityGates.md, NotionOperatingSystem.md, ../Templates/SprintPlanning.md, ../Templates/SprintReview.md, ../Templates/SprintRetrospective.md]
---

# Sprint management

How Desktop Frame plans, runs, and closes a unit of work. The mechanics of tracking live in Notion (Sprint Tracker, Task Tracker); this document defines the process those databases support.

## Purpose

Turn the roadmap into a predictable two-week cadence of shippable increments, with enough structure to stay accountable and little enough to avoid ceremony for its own sake.

## Scope

Applies to all feature, fix, and engineering work. Research spikes are timeboxed inside a sprint but tracked separately so they do not distort velocity. Out of scope: long-range roadmap planning, which is quarterly (see [ProjectLifecycle.md](ProjectLifecycle.md)).

## Ownership

The Engineering Manager owns the process. The Product agent owns backlog priority. Each task has one assignee accountable for it reaching Done.

## Inputs

- A prioritized backlog in the Notion Task Tracker.
- The roadmap milestone the sprint serves.
- Velocity from recent sprints.
- Capacity for the sprint (people, days, known interruptions).

## Outputs

- A committed sprint backlog with estimates.
- A shippable increment that passes the [QualityGates.md](QualityGates.md).
- A sprint review record and a retrospective record in Notion.
- Updated velocity.

## Workflow

Sprint length is two weeks. The ceremonies:

1. Planning, day one. The team pulls the top of the backlog into the sprint until capacity is reached. Each item must meet the Definition of Ready below. Items are estimated and assigned.
2. Daily check, asynchronous. Each contributor records progress and blockers in the Daily Development Log (Notion). Blockers older than a day escalate to the Engineering Manager.
3. Backlog refinement, mid-sprint. The Product agent grooms the next sprint's candidates so planning is fast.
4. Review, last day. Demonstrate the increment against acceptance criteria. Record what shipped and what slipped.
5. Retrospective, last day. What to keep, change, and try. One or two concrete actions, owned and dated.

### Estimation

Story points on a modified Fibonacci scale (1, 2, 3, 5, 8). An 8 is a signal to split. Estimates measure relative effort and uncertainty, not hours.

### Priority

Critical, High, Medium, Low, Nice to Have, matching the Notion Task Tracker. Priority and estimate together order the backlog.

### Definition of Ready

A task is ready to enter a sprint when it has a clear outcome, acceptance criteria, an estimate, and no unresolved dependency. Unready items stay in the backlog.

### Definition of Done

A task is done when it passes the review checklist in [/CLAUDE.md](../../CLAUDE.md) and the [QualityGates.md](QualityGates.md): built, tested, documented, reviewed, merged. "Code complete" is not done.

## Required templates

- [../Templates/SprintPlanning.md](../Templates/SprintPlanning.md)
- [../Templates/SprintReview.md](../Templates/SprintReview.md)
- [../Templates/SprintRetrospective.md](../Templates/SprintRetrospective.md)
- [../Templates/DailyDevelopmentLog.md](../Templates/DailyDevelopmentLog.md)

## Required reviews

Planning and review are team ceremonies. The retrospective's actions are reviewed at the next planning to confirm they happened.

## Success criteria

A sprint succeeds when the committed increment ships, passes the quality gates, and the team's forecast matched reality within a reasonable margin.

## KPIs

- Velocity, tracked over a rolling average, used for forecasting not judgment.
- Commitment reliability: share of committed points completed.
- Carryover: points pulled into the next sprint.
- Escaped defects: bugs found after a sprint closed the work that caused them.

## Common failure cases

- Over-committing to a full-capacity sprint with no slack, so any surprise causes carryover. Plan to roughly 80% of raw capacity.
- Treating velocity as a target to inflate rather than a forecasting input.
- Skipping the retrospective when busy, which is exactly when it matters.
- Letting unready items into a sprint, where they stall mid-flight.

## Best practices

- Keep tasks small enough to finish in a few days. Large tasks hide risk.
- Close to Done daily; do not batch a week of "almost done" into the last afternoon.
- Protect the sprint from mid-flight scope changes; new urgent work displaces planned work explicitly, it is not added on top.
