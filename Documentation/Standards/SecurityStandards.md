---
title: Security standards
status: Active
owner: Security
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../Processes/QualityGates.md, ../Processes/IncidentManagement.md, ../../.agents/SECURITY_AGENT.md]
---

# Security standards

The rules that protect the user's data and the app's trustworthiness. Privacy is a product value, not a compliance afterthought.

## Data

- User data stays on device by default. Anything leaving the device requires explicit, informed consent.
- No telemetry or analytics without opt-in consent.
- Store only what the product needs, for as long as it needs it.

## Permissions

- Request permissions (Calendar, Reminders, Accessibility, Screen Recording) at the point of use, not on launch.
- Each request carries an honest purpose string that says why access is needed.
- Request the narrowest entitlement that works (least privilege).
- The app degrades gracefully when a permission is denied; denial is a supported state, not an error.

## APIs and sandbox

- Public Apple APIs only. No private API that risks breakage or App Review rejection.
- Run sandboxed with the minimum entitlements. Each entitlement is justified in writing.
- Plugins inherit these rules and are contained; a plugin cannot exceed the app's privileges.

## Enforcement

A change with security surface attaches a [security review](../Templates/SecurityReview.md) and passes the security gate in [QualityGates.md](../Processes/QualityGates.md), owned by the Security agent. Any data leaving the device is escalated to a human regardless of consent design.

## Incidents

A privacy or security exposure follows [IncidentManagement.md](../Processes/IncidentManagement.md) and the disclosure path in `.github/SECURITY.md`. Data leaving the device without consent is a Sev 1 incident.

## Common pitfalls

- Adding analytics "just to understand usage" without consent.
- Requesting a broad entitlement up front to avoid asking later.
- A purpose string that under-describes what is actually accessed.
- A plugin path that could read more than the user agreed to.
