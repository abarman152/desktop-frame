---
title: Incident management
status: Active
owner: Engineering Manager
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [BugManagement.md, ReleaseManagement.md, ../Templates/IncidentReport.md, ../Templates/RootCauseAnalysis.md]
---

# Incident management

How Desktop Frame responds when a shipped release harms users: crashes, data loss, runaway resource use, or a security exposure. A bug is a defect in the queue; an incident is a defect hurting users now.

## Purpose

Restore users to safety quickly, then understand and prevent the cause, with a calm and repeatable response rather than improvisation.

## Scope

Any production issue with user impact: a crash affecting many users, data loss, battery or CPU damage, a privacy or security exposure. Lesser defects stay in [BugManagement.md](BugManagement.md).

## Ownership

The Engineering Manager is the incident owner by default and may delegate an incident lead per event. The lead coordinates response, communication, and the postmortem.

## Inputs

- An incident signal: user reports, crash data, a security disclosure.
- The affected versions and environments.

## Outputs

- A mitigation or hotfix that stops the harm.
- An incident report and a blameless root cause analysis.
- Prevention actions tracked to completion.

## Workflow

1. Declare. Anyone can declare an incident. Declaring is cheap; under-reacting is not.
2. Assess severity and assign a lead.
3. Mitigate. Stop the harm first, even with a temporary measure (pull the build, disable a feature, ship a hotfix per [ReleaseManagement.md](ReleaseManagement.md)). Fixing the root cause comes after the bleeding stops.
4. Communicate. Tell affected users what happened and what to do, honestly and without minimizing.
5. Resolve. Confirm the harm has stopped.
6. Learn. Write a blameless root cause analysis and an incident report. Turn the causes into tracked prevention actions.

### Severity

| Severity | Example | Response |
|---|---|---|
| Sev 1 | Data loss, security exposure, crash on launch for many users | Immediate, all hands, mitigate now |
| Sev 2 | A core feature broken in production, harm to the Mac | Urgent, same day |
| Sev 3 | Notable but bounded production issue with a workaround | Prioritized, next release or hotfix |

### Security incidents

A security or privacy exposure is at least Sev 2 and follows the disclosure path in `.github/SECURITY.md`. Data leaving the device without consent is always Sev 1.

## Required templates

[../Templates/IncidentReport.md](../Templates/IncidentReport.md) and [../Templates/RootCauseAnalysis.md](../Templates/RootCauseAnalysis.md).

## Required reviews

Every Sev 1 and Sev 2 incident has a postmortem reviewed by the Principal Engineer. Prevention actions are reviewed to closure at the monthly review.

## Success criteria

User harm is stopped quickly, the cause is understood, and prevention actions land. The same incident does not recur.

## KPIs

- Time to mitigate and time to resolve, by severity.
- Recurrence: incidents from a cause a prior postmortem identified.
- Prevention-action completion rate.

## Common failure cases

- Chasing the root cause while users are still being harmed. Mitigate first.
- A blameful postmortem that makes people hide problems instead of surfacing them.
- Prevention actions written down and never done.

## Best practices

- Declare early; a stand-down is cheaper than a late response.
- Keep postmortems blameless and specific; the goal is a safer system, not a culprit.
- Treat every incident as a gap in the quality gates or the risk register, and close that gap.
