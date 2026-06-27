---
title: Documentation lifecycle
status: Active
owner: Documentation Lead
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../Standards/DocumentationStandards.md, ../README.md, NotionOperatingSystem.md, QualityGates.md]
---

# Documentation lifecycle

When documentation must be written, updated, reviewed, and retired. The format rules are in [../Standards/DocumentationStandards.md](../Standards/DocumentationStandards.md); this document governs timing.

## Purpose

Keep documentation accurate by tying its updates to the events that make it stale, so docs never drift from the code.

## Scope

Every Markdown document in the repository, and the Notion pages that mirror them. Notion-only living documents (meeting notes, daily logs) follow their own cadence in [NotionOperatingSystem.md](NotionOperatingSystem.md).

## Ownership

Each document names an `owner` in frontmatter, accountable for accuracy. The Documentation Lead owns the lifecycle process and runs the periodic review.

## Inputs

- Code changes, architecture decisions, and releases that affect documented behavior.
- The `review_by` dates across the documentation set.

## Outputs

- Documents whose content matches the current system.
- A quarterly review record listing what was re-verified, updated, or deprecated.

## Workflow

Documentation updates are triggered by events, not by a separate schedule.

| Trigger | Required documentation action |
|---|---|
| Before implementation | The design or spec exists and is accepted (architecture doc, feature spec, or ADR) |
| During implementation | Update the spec if the design changes; keep it true |
| After implementation | Update affected docs in the same pull request; update the Notion Documentation Index if a doc was added |
| Before release | Release notes and migration guide written; changelog updated |
| After release | Version history updated; superseded docs marked |
| During refactoring | Update any doc the refactor makes inaccurate, in the same change |
| After an architecture change | The governing ADR is written or superseded before merge |

A document that contradicts the code is a bug, fixed with the same urgency as a code bug of equal impact.

### Status transitions

`Draft` while being written. `Active` once accurate and in use. `Deprecated` when no longer recommended but not yet replaced. `Superseded` when a named successor exists, linked both ways. ADRs are immutable after `Accepted` and only change status.

### Periodic review

Quarterly, the Documentation Lead lists every document past its `review_by` date. Each is re-verified against the system, updated and given a new date, or deprecated. The review produces a record using the meeting-notes template.

## Required templates

The matching template in `Documentation/Templates/` for whatever document type is being created. The quarterly review uses [../Templates/MeetingNotes.md](../Templates/MeetingNotes.md).

## Required reviews

Documentation changes are reviewed in the pull request that contains them. Standards and ADRs are reviewed by the Principal Engineer; process docs by the Engineering Manager; everything else by any qualified reviewer.

## Success criteria

No document past its `review_by` date sits unreviewed after a quarterly cycle. No shipped behavior contradicts an `Active` document.

## KPIs

- Stale-doc count: `Active` documents past `review_by`.
- Doc-with-code rate: share of code PRs that updated documentation when they changed documented behavior.
- Time from behavior change to doc update.

## Common failure cases

- Deferring the doc update to a follow-up PR that never lands. Update in the same change.
- Letting `review_by` dates pass unnoticed because no one runs the review. The quarterly cycle is a calendar commitment.
- Editing an ADR instead of superseding it.

## Best practices

- Write the spec before the code; update it when the code teaches you something.
- Treat the Notion Documentation Index as the canonical list of what repository docs exist, and keep it current.
- When in doubt about whether a change needs a doc update, it does.
