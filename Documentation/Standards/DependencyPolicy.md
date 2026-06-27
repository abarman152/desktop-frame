---
title: Dependency policy
status: Active
owner: Principal Engineer
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../Processes/ChangeManagement.md, ../Processes/VersioningStrategy.md]
---

# Dependency policy

When Desktop Frame takes on a dependency, and the bar it must clear. Every dependency is a long-term liability as much as a short-term convenience, so each is chosen deliberately. The live list is the Notion Dependency Registry.

## Default position

Prefer Apple frameworks and the standard library. Reach for a third-party dependency only when building it ourselves would be worse, and only when the dependency is healthy and its license is compatible.

## Adding a dependency

Adding, removing, or upgrading a dependency is a consequential change under [ChangeManagement.md](../Processes/ChangeManagement.md). It requires:

- A justification: what it does that we should not build ourselves.
- A license check: compatible with shipping a commercial Mac app.
- A health check: maintained, reasonable size, no abandoned transitive risk.
- An owner in the Dependency Registry.
- Approval per change management.

## Constraints

- No dependency that pulls in a non-native UI layer.
- No dependency that requires a private Apple API.
- No dependency that sends data off device.
- Pin versions; upgrades are deliberate and tested, not automatic.

## Review

The dependency set is reviewed quarterly: each entry re-justified, unhealthy ones flagged, unused ones removed. A dependency upgrade follows [VersioningStrategy.md](../Processes/VersioningStrategy.md) for its compatibility impact.

## Common pitfalls

- Adding a large dependency for a small utility we could write in an afternoon.
- Inheriting a transitive dependency nobody evaluated.
- Letting versions float, so a build is not reproducible.
