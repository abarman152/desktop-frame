---
title: Security review — <change>
status: Draft
owner: Security
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
related: []
---

<!--
TEMPLATE: Security review. Required for changes with security surface. Follows
../Standards/SecurityStandards.md.
-->

# Security review — <change>

## Scope

What the change does that touches permissions, data, the sandbox, or the network.

## Data handling

What data is read, stored, or transmitted, and where it goes. Confirm it stays on device unless the user opted in.

## Permissions and entitlements

What is requested, why, when (point of use), and the purpose string. Confirm least privilege and graceful degradation on denial.

## API usage

Confirm public APIs only; no private API that risks App Review.

## Findings and actions

Issues found and what fixes them.

## Completion checklist
- [ ] Data handling traced; on-device or explicit consent.
- [ ] Permissions least-privilege, at point of use, with honest purpose strings.
- [ ] Public APIs only confirmed.
- [ ] Graceful degradation on denial verified.

## Review checklist
- [ ] No data leaves the device without consent.
- [ ] No private-API or over-broad entitlement.
- [ ] Meets DocumentationStandards.
