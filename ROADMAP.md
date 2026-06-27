# Desktop Frame — Roadmap

This roadmap is the public, high-level view of where Desktop Frame is going. It
mirrors the milestone plan in the
[Product Requirements Document](Documentation/) and the detailed, living roadmap
maintained in Notion. When this file and the PRD disagree, the PRD wins and this
file is corrected in the same change.

> **Direction over dates.** Desktop Frame is built to a quality bar, not a
> calendar. Milestones ship when they clear the [quality gates](Documentation/Processes/QualityGates.md);
> the performance and security budgets are release gates, not aspirations. The
> sequence below is committed; the timing is not.

## The arc: surface → system → platform

Desktop Frame is sequenced in three stages, each a coherent product on its own:

1. **The surface** — a desktop people prefer to the default and keep running.
2. **The system** — how people run their desktop, day to day.
3. **The platform** — what others build on, via an SDK and marketplace.

## Milestones

### MVP — The surface · _in progress_
The smallest product that proves the wedge: native, no-code, and performant.
- Desktop Canvas: a transparent layer below the icons, on every display.
- Widget Engine with live, interactive widgets (no code required).
- System monitoring widgets: CPU, memory, battery, network.
- Static and basic live wallpaper (hardware-decoded, within the energy budget).
- First-class multi-monitor support.
- No-code Settings.

**Exit:** a desktop people keep running, holding the performance budget on a laptop all day.

### v0.2 — Data
Always-visible information without app switching.
- Calendar and Reminders widgets (EventKit, permission at point of use).
- Weather, clock, and an expanded widget set.

**Exit:** daily-active data widgets.

### v0.5 — The system
How people run their desktop.
- Visual Layout Manager: arrange, snap, align, and group, free of Apple's grid.
- Theme Engine: tokenized, wallpaper-aware theming across widgets.
- Richer dynamic wallpaper; per-display profiles.
- Calm notification surfacing (gated on UX research).

**Exit:** week-4 retention; the desktop people rely on.

### v1.0 — The platform
From app to platform.
- Plugin SDK: a documented, sandboxed API for third-party widgets.
- Widget Marketplace: discover, install, and share widgets and themes.
- Backup & Sync across a user's Macs via iCloud.
- Developer tooling, docs, and samples.
- On-device, opt-in AI widgets (Foundation Models) — additive, never required.

**Exit:** third-party widgets installed by real users; sustainable economics.

### Post-1.0 — The standard · _future_
- Window-manager integration that complements (not replaces) Rectangle.
- Cross-device companion, Shortcuts and automation, managed profiles for teams.

## Principles that shape the roadmap

- **Native first.** SwiftUI and AppKit only. No Electron, no cross-platform UI.
- **Performance is a feature.** Idle CPU under 0.5%/core, under 80 MB resident,
  widget render under 8 ms at 120 Hz. Measured with Instruments, never estimated.
- **Privacy by default.** All user data stays on device unless the user opts in.
  No telemetry without consent.
- **Earn the platform.** The marketplace is built only after the surface earns retention.

## Tracking

Detailed, continuously updated planning — epics, sprints, and the feature
catalog — lives in Notion. This file is reviewed at every milestone boundary.
See also [CHANGELOG.md](CHANGELOG.md) for what has actually shipped.
