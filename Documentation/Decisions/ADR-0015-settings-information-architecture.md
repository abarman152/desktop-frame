---
title: ADR-0015 Settings information architecture
status: Accepted
owner: UX Architect
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [../UX/SettingsUX.md, ../UX/InformationArchitecture.md, ../Components/Navigation.md, ../Standards/SecurityStandards.md, ADR-0014-direct-manipulation-widget-interaction-model.md]
---

# ADR-0015: Settings information architecture

## Status

Accepted — 2026-06-27.

## Context

Desktop Frame is deeply customisable — widgets, appearance, wallpaper, performance, privacy, plugins, updates, backup — yet must keep a calm first screen and low cognitive load ("default to less", [DesignPhilosophy](../Design/DesignPhilosophy.md)). Most configuration happens by direct manipulation on the surface ([ADR-0014](ADR-0014-direct-manipulation-widget-interaction-model.md)); the rest needs a configuration surface. Prior-art research shows config-heavy tools overwhelm users ([DesktopCustomizationUXResearch](../Research/DesktopCustomizationUXResearch.md)), and macOS users already know the System Settings pattern. Privacy controls must be honest and consent-first ([SecurityStandards](../Standards/SecurityStandards.md)).

## Problem

How should the Settings surface be structured and navigated so the product's full configurability is available without overwhelming the user or burying controls?

## Alternatives considered

1. **Single long scrolling preferences page.** Everything visible; familiar to some apps. Becomes an unscannable wall as the product grows; poor for search and accessibility. Rejected.
2. **Deep nested hierarchy (categories within categories).** Scales to many settings but hides controls several levels deep and raises navigation cost; users can't predict where something lives. Rejected.
3. **Standard macOS sidebar + detail panes with search and progressive disclosure (chosen).** A shallow set of top-level panes, each showing common controls with advanced behind a disclosure, plus a flat search that deep-links to any control.

## Decision

Adopt the **standard macOS Settings pattern**: a source-list sidebar of shallow top-level panes driving a detail view, opened with ⌘,, with **progressive disclosure** inside each pane and a **flat search** that deep-links to any individual setting ([SettingsUX](../UX/SettingsUX.md), [Components/Navigation](../Components/Navigation.md)). Decided by the UX Architect with UI/UX. The pane set: General, Appearance, Widgets, Wallpaper, Performance, Privacy & Permissions, Plugins, Updates, Backup & Restore, Accessibility, Advanced/Developer. Navigation is shallow (surface → pane → disclosed section, never deeper); common controls are visible, advanced is one disclosure deep, expert is behind a mode; search is the flat escape hatch so disclosure never means "lost". Privacy controls are consent-first and never dark-pattern toward granting ([SecurityStandards](../Standards/SecurityStandards.md)). Plugin-contributed settings register within this structure ([PluginSDK](../Architecture/PluginSDK.md)).

## Trade-offs

The standard pattern forgoes a novel, differentiated configuration UX, and progressive disclosure hides advanced controls a step deeper (a small discoverability cost, mitigated by search). We accept these for familiarity, low cognitive load, accessibility, and a structure that scales as the product grows.

## Consequences

- Settings is built from the Sidebar + Preference-pane components ([Components/Navigation](../Components/Navigation.md)); panes have a consistent layout and logical focus order.
- Every advanced control must remain reachable via search, so search indexes all settings, not just panes ([Components/Controls](../Components/Controls.md)).
- New features add or extend a pane within this map, not a new top-level surface, keeping the IA shallow ([InformationArchitecture](../UX/InformationArchitecture.md)).
- The Privacy pane is the single review/revoke point; permission primers live in-context ([UserFlows](../UX/UserFlows.md)).

## References

1. [SettingsUX](../UX/SettingsUX.md) · [InformationArchitecture](../UX/InformationArchitecture.md) · [Components/Navigation](../Components/Navigation.md) · [SecurityStandards](../Standards/SecurityStandards.md).
2. Apple, "HIG — Settings." https://developer.apple.com/design/human-interface-guidelines/settings
