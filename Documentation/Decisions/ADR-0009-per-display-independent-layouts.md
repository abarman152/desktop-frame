---
title: ADR-0009 Per-display independent layouts keyed by stable display identity
status: Accepted
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-12-27
related: [../Architecture/MultiMonitorArchitecture.md, ../Architecture/WindowSystem.md]
---

# ADR-0009: Per-display independent layouts keyed by stable display identity

## Status

Accepted — 2026-06-27.

## Context

Macs are routinely multi-display and the configuration is fluid: external monitors are hot-plugged, resolutions change, displays are rearranged, and the same laptop meets different monitors at home and at the office. The scaffolding reserves `AppConstants.Storage.monitorMapKey` and a `monitorConfigurationChanged` notification, anticipating that layout is per-display. A widget arrangement that is meaningful on a 27-inch 5K display is meaningless when that display disappears or is replaced.

## Problem

How is widget/wallpaper layout associated with displays, and what identity keys a layout, so arrangements survive hot-plug, rearrangement, and resolution change and reattach to the right physical screen?

## Alternatives considered

1. **One global layout for all displays.** Simple, but a single arrangement cannot fit displays of different sizes and counts, and it thrashes on every configuration change.
2. **Layout keyed by `NSScreen` array index.** Trivial to compute, but the index is positional and unstable: unplug one monitor and every other layout shifts to the wrong screen.
3. **Layout keyed by `CGDirectDisplayID`.** Stable within a session, but reassigned across reboots and reconnects, so it does not durably identify a physical display.
4. **Layout keyed by a stable per-display identity** derived from the display's persistent attributes (vendor/model/serial via the display's UUID where available), with graceful fallback.

## Decision

Each display has an **independent layout** (its own widget placement and wallpaper). Layouts are keyed by a **stable display identity** computed from the display's durable hardware attributes, persisted in the monitor map. On a configuration change (`monitorConfigurationChanged`), the system matches present displays to stored identities, reattaches each display's layout, and holds detached layouts in reserve rather than discarding them, so a reconnected monitor restores its arrangement. A display seen for the first time gets a sensible default layout. A shared/mirrored layout is offered as an explicit user choice on top of the per-display default, not the underlying model. Decided by the founding engineering team.

## Trade-offs

A stable identity is more work than an array index and must handle displays that expose no serial (identical external monitors are genuinely ambiguous). We accept that complexity because positional keying produces the worst user-visible failure — layouts jumping to the wrong screen on every plug event — and that failure is unacceptable on a product whose whole point is the desktop arrangement.

## Consequences

- The [MultiMonitorArchitecture](../Architecture/MultiMonitorArchitecture.md) owns the identity computation and the match/reattach algorithm, including the ambiguous-identical-displays fallback.
- Detached layouts are retained, not deleted, so reconnect is non-destructive; this is a named invariant.
- Resolution/scale changes reflow a layout within the same display identity rather than treating it as a new display.
- One `DesktopWindow` exists per active display (see [WindowSystem](../Architecture/WindowSystem.md)), each bound to that display's identity and layout.

## References

1. Apple, "NSScreen." https://developer.apple.com/documentation/appkit/nsscreen
2. Apple, "CGDirectDisplayID and display reconfiguration." https://developer.apple.com/documentation/coregraphics/quartz_display_services
