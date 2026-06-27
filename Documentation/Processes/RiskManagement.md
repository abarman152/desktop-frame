---
title: Risk management
status: Active
owner: Principal Engineer
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [IncidentManagement.md, ChangeManagement.md, ProjectLifecycle.md, NotionOperatingSystem.md]
---

# Risk management

How Desktop Frame identifies, tracks, and reduces the things that could derail it. The register lives in the Notion Risk Register; this document defines how it is run.

## Purpose

Surface risks while they are still cheap to address, and assign each an owner and a mitigation, so the project is not surprised by something it could have seen.

## Scope

Technical, platform, performance, security, schedule, and legal risks to the product. Day-to-day defects are bugs, not risks, until a pattern of them becomes a risk.

## Ownership

The Principal Engineer owns the register. Each risk has a named owner accountable for its mitigation.

## Inputs

- Risks raised in design, research, retrospectives, and incidents.
- Platform signals: Apple API deprecations, OS changes, App Review policy shifts.

## Outputs

- A maintained Risk Register with status, likelihood, impact, owner, and mitigation.
- Mitigations tracked to completion.
- Risks that materialize handed to [IncidentManagement.md](IncidentManagement.md).

## Workflow

1. Identify. Anyone can raise a risk. Capture it with a clear description of the mechanism, not a vague worry.
2. Assess. Rate likelihood (High, Medium, Low) and impact (Critical, High, Medium, Low).
3. Plan. Assign an owner and a mitigation, or consciously accept the risk and record why.
4. Track. Review open risks at the monthly review; update status.
5. Close. A risk closes when mitigated, accepted, or no longer applicable.

### Known standing risks

The product's strategic risks are reasoned through in the Notion Product documentation (Vision, Opportunity Analysis). The register holds the live, trackable engineering and platform risks, for example: Apple tightening the window-level APIs the desktop layer relies on, a performance regression confirming the "kills your battery" reputation, or a private-API temptation that threatens App Review.

## Required templates

Risks are tracked in the Notion Risk Register. A risk that becomes an incident uses [../Templates/IncidentReport.md](../Templates/IncidentReport.md).

## Required reviews

Open risks are reviewed monthly. Critical-impact risks are reviewed by the Principal Engineer whenever their status changes.

## Success criteria

Every Critical or High risk has an owner and a live mitigation. No risk that materialized into an incident was absent from the register beforehand without reason.

## KPIs

- Open risk count by severity, trended.
- Mitigation completion rate and age of open mitigations.
- Risks that became incidents, and whether they were tracked first.

## Common failure cases

- A register that is written once and never reviewed, so it ages into fiction.
- Vague risks with no mechanism and no owner, which cannot be acted on.
- Accepting a risk implicitly by ignoring it, rather than explicitly with a reason.

## Best practices

- State each risk as a mechanism with a trigger, not a feeling.
- Pair every risk with the cheapest mitigation that meaningfully reduces it.
- Review the register on a fixed monthly date so it never goes stale.
