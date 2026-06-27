---
title: ADR-0007 Out-of-process plugin isolation
status: Accepted
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-12-27
related: [../Architecture/PluginSDK.md, ../Standards/SecurityStandards.md, ../Architecture/WidgetEngine.md]
---

# ADR-0007: Out-of-process plugin isolation

## Status

Accepted — 2026-06-27. Foundational direction; the concrete IPC schema is detailed in [PluginSDK](../Architecture/PluginSDK.md) and will be refined by a follow-up ADR when the SDK is built.

## Context

Desktop Frame is on a path to a third-party plugin SDK and a marketplace. Third-party code on an always-on surface is both a security boundary (it must not exceed the app's privileges or read what the user did not consent to) and a reliability boundary (a crashing or hung plugin must not take down the desktop layer or the user's session). [SecurityStandards](../Standards/SecurityStandards.md) already requires that "plugins inherit these rules and are contained; a plugin cannot exceed the app's privileges," and the App Sandbox is mandatory.

## Problem

In what isolation domain does third-party plugin code execute, so a faulty or hostile plugin cannot crash the host, exceed its entitlements, or read other plugins' or the user's data?

## Alternatives considered

1. **In-process dynamic loading (`dlopen`/bundles).** Lowest latency and simplest API, but a plugin shares the host address space: a crash is the host's crash, and sandbox/entitlement separation is impossible. Unacceptable for untrusted code.
2. **In-process with a scripting sandbox (e.g., JavaScriptCore).** Memory-safe and embeddable, but limits plugins to a scripted subset, complicates native rendering, and still shares the host process for reliability.
3. **Out-of-process plugins over XPC, each in its own sandboxed service.** OS-enforced process and entitlement isolation; a plugin crash is contained; each plugin gets only the entitlements it declares and the user grants. Higher latency and a serialization boundary.
4. **Full virtualization / containers.** Strongest isolation, wildly disproportionate for desktop widgets.

## Decision

Third-party plugins run **out of process** as sandboxed XPC services, each with its own entitlement set and its own crash domain. The host defines a stable, versioned plugin protocol; plugins render through a constrained surface (data + a declarative view description, or a Tier-1 SwiftUI subset), not by drawing directly into the host's windows. First-party built-in widgets may run in-process during early milestones, but the *public* SDK boundary is out-of-process from its first release. Decided by the founding engineering team.

## Trade-offs

XPC adds latency, a serialization contract, and lifecycle complexity (launching, restarting, supervising services) compared to in-process loading. We accept that cost because reliability and security isolation of third-party code is non-negotiable for a marketplace, and the boundary cannot be retrofitted cheaply once an in-process API is public.

## Consequences

- The plugin API is a serializable, versioned contract; rich object graphs do not cross the boundary. See [PluginSDK](../Architecture/PluginSDK.md).
- The [WidgetEngine](../Architecture/WidgetEngine.md) supervises plugin processes: launch, health, restart, and resource caps.
- A plugin's GPU/Tier-3 access is a granted capability, not a default; high-frequency rendering across XPC needs a shared-surface design (`IOSurface`) recorded when the SDK is built.
- Permissions are per-plugin and least-privilege per [SecurityStandards](../Standards/SecurityStandards.md); a plugin cannot exceed the host's sandbox.

## References

1. Apple, "XPC." https://developer.apple.com/documentation/xpc
2. Apple, "App Sandbox." https://developer.apple.com/documentation/security/app-sandbox
