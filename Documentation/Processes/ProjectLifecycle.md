---
title: Project lifecycle
status: Active
owner: Engineering Manager
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [SprintManagement.md, RiskManagement.md, ReleaseManagement.md, NotionOperatingSystem.md]
---

# Project lifecycle

How work flows from an idea to a shipped, supported feature across the longer horizons that sit above a sprint. Sprints are the engine; this document is the road.

## Purpose

Connect the daily sprint cadence to quarterly planning and the multi-year roadmap, so short-term work serves long-term direction.

## Scope

The full arc of a unit of value: idea, validation, specification, build, release, support, retirement. Applies to features and to platform capabilities. Routine fixes skip the early stages and enter at build.

## Ownership

The Engineering Manager owns the lifecycle. The Product agent owns the early stages (idea to spec); engineering owns build to release; the whole team owns support.

## Inputs

- The roadmap and its milestones (Notion Roadmap).
- Ideas and research (Notion Ideas, Research).
- Capacity and velocity.

## Outputs

- Shipped features tied to roadmap milestones.
- A maintained roadmap reflecting reality.
- Retirement decisions for capabilities no longer worth their cost.

## The stages

| Stage | What happens | Exit gate |
|---|---|---|
| Idea | Captured in Notion Ideas; loosely sized | Promoted to research or backlog, or rejected with a reason |
| Validation | Research, prior art, user evidence ([../Templates/ResearchReport.md](../Templates/ResearchReport.md)) | Evidence supports building, or it does not |
| Specification | PRD and feature spec written and accepted; ADR if architectural | Spec meets Definition of Ready |
| Build | Implemented across sprints per [SprintManagement.md](SprintManagement.md) | Passes [QualityGates.md](QualityGates.md) |
| Release | Shipped per [ReleaseManagement.md](ReleaseManagement.md) | Released and verified |
| Support | Bugs and feedback handled; usage observed | Stable, or flagged for change |
| Retirement | A capability is deprecated and removed when its cost outweighs its value | Removed with a migration path |

## Planning horizons

- Quarterly: pick the milestones for the next three months from the roadmap; size them against capacity.
- Monthly: review progress against the quarter; adjust.
- Sprint: two-week execution.
- Daily: progress and blockers in the development log.

The review cadence (weekly, monthly, quarterly) is run in Notion per [NotionOperatingSystem.md](NotionOperatingSystem.md).

## Required templates

[../Templates/ResearchReport.md](../Templates/ResearchReport.md), [../Templates/ProductRequirementDocument.md](../Templates/ProductRequirementDocument.md), [../Templates/FeatureSpecification.md](../Templates/FeatureSpecification.md), [../Templates/Epic.md](../Templates/Epic.md).

## Required reviews

Each stage gate is a review. Specification is reviewed by engineering and product together. Retirement is a Principal Engineer and Product decision.

## Success criteria

Work in flight traces to a roadmap milestone. Ideas do not jump straight to build without validation and a spec. The roadmap reflects what is actually happening.

## KPIs

- Idea-to-release lead time.
- Share of shipped work tied to a roadmap milestone.
- Roadmap accuracy: planned versus delivered per quarter.

## Common failure cases

- Building before validating, so effort goes to features nobody adopts.
- A roadmap that is aspirational fiction because it is never reconciled with delivery.
- Capabilities that accumulate forever because nothing is ever retired.

## Best practices

- Kill ideas early and cheaply at the validation gate; it is the least expensive place to say no.
- Keep the roadmap honest by reconciling it monthly against what shipped.
