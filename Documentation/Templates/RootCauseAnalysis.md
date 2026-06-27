---
title: RCA — <issue>
status: Draft
owner: <author>
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
related: []
---

<!--
TEMPLATE: Root cause analysis. Required for Critical/High bugs and Sev 1/2
incidents. Follows ../Processes/BugManagement.md and IncidentManagement.md.
Blameless; find the cause, not the culprit.
-->

# RCA — <issue>

## Summary

What happened, in a few sentences.

## Root cause

The actual cause, reached by asking why until the chain ends at a systemic gap, not a person. Distinguish the trigger from the underlying cause.

## Contributing factors

Conditions that made the problem possible or worse.

## Detection

How it was found, and how it could have been found sooner.

## Corrective actions

What fixes the instance and what fixes the class, each owned and dated. A recurring class of issue becomes an ADR or a standard.

## Completion checklist
- [ ] Root cause reaches a systemic gap, not a person.
- [ ] Trigger distinguished from underlying cause.
- [ ] Corrective actions owned and dated.

## Review checklist
- [ ] Blameless and specific.
- [ ] Actions address the class, not just the instance.
- [ ] Meets DocumentationStandards.
