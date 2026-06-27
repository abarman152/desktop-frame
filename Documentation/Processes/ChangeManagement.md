---
title: Change management
status: Active
owner: Engineering Manager
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [GitWorkflow.md, QualityGates.md, ../Decisions/README.md, RiskManagement.md]
---

# Change management

How a change is proposed, assessed, approved, and recorded, so the codebase changes deliberately rather than by accretion. The git mechanics are in [GitWorkflow.md](GitWorkflow.md); this document covers the decision around a change.

## Purpose

Ensure every consequential change is intentional, assessed for impact, and traceable, without adding process to routine work.

## Scope

Changes that affect architecture, public interfaces, data formats, dependencies, or shared behavior. Routine, localized changes follow the normal pull-request flow and need nothing extra.

## Ownership

The Engineering Manager owns the process. The change's author owns its impact assessment. The Architect agent approves architectural changes.

## Inputs

- A proposed change with its motivation.
- The affected subsystems and interfaces.

## Outputs

- An approved change with a recorded decision (an ADR for architecture, a PR description otherwise).
- An impact assessment for anything touching shared surface.

## Workflow

1. Classify. Is this routine (localized, reversible, fits patterns) or consequential (architecture, interface, data format, dependency)?
2. For routine changes: normal PR flow and quality gates. Stop here.
3. For consequential changes: assess impact (who and what it affects, how to reverse it), write the decision record (ADR for architecture per [../Decisions/README.md](../Decisions/README.md)), and get the right approval.
4. Implement incrementally, keeping the build green.
5. Record. The decision and its rationale live in the ADR or the PR, never only in a chat.

### Dependency changes

Adding, removing, or upgrading a dependency follows [../Standards/DependencyPolicy.md](../Standards/DependencyPolicy.md) and is always consequential: it needs justification, a license check, and an owner.

## Required templates

[../Templates/DecisionRecord.md](../Templates/DecisionRecord.md) for architectural change; [../Templates/DesignProposal.md](../Templates/DesignProposal.md) for a substantial proposal before it becomes a decision.

## Required reviews

Architectural changes are approved by the Architect agent or Principal Engineer. Dependency changes are approved per the dependency policy. Routine changes need one reviewer.

## Success criteria

No architectural change reaches `main` without an ADR. Every consequential change has a recorded rationale a future contributor can find.

## KPIs

- Share of architectural changes with an ADR (target: all).
- Reverted consequential changes, and whether the reversal was anticipated in the impact assessment.

## Common failure cases

- Architecture changing through a series of "small" PRs that were never assessed as a whole.
- Decisions living only in pull-request comments or chat, lost within months.
- Dependencies added casually, becoming liabilities nobody chose deliberately.

## Best practices

- When unsure whether a change is consequential, treat it as consequential; the cost is one short document.
- Separate the decision (ADR) from the implementation (PR), so the reasoning outlives the diff.
