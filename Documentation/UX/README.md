---
title: UX index
status: Active
owner: UI/UX
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [InteractionModel.md, ../Design/README.md, ../Components/README.md, ../Research/DesktopCustomizationUXResearch.md]
---

# UX index

The experience architecture of Desktop Frame: how the product behaves, how a user moves through it, and the research behind those choices. Where [Design](../Design/README.md) owns the *language* and [Components](../Components/README.md) own the *parts*, UX owns the *behaviour* — the interaction model, the widget/wallpaper/settings experiences, the information architecture, and the flows. It is documented as architecture, not built UI.

## Read in this order

1. [Interaction model](InteractionModel.md) — the grammar of every input on the surface.
2. [Information architecture](InformationArchitecture.md) — how the product is structured and navigated.
3. [Widget UX](WidgetUX.md), [Wallpaper UX](WallpaperUX.md), [Settings UX](SettingsUX.md) — the three core experiences.
4. [User flows](UserFlows.md) — journeys, onboarding, recovery, power-user paths.

## Documents

| Document | Owns |
|---|---|
| [Interaction model](InteractionModel.md) | Hover/click/drag/resize/snap/selection/keyboard/gestures/focus/undo; Mission Control, Stage Manager, Spaces, multi-monitor |
| [Widget UX](WidgetUX.md) | Adding, moving, resizing, configuring, grouping, layering, docking, pinning, persisting, editing widgets |
| [Wallpaper UX](WallpaperUX.md) | Picking, previewing, cropping, scaling, and transitioning wallpaper across types |
| [Settings UX](SettingsUX.md) | The Settings structure, navigation, search, and every pane |
| [Information architecture](InformationArchitecture.md) | The product's structure, navigation map, mental models, cognitive load, progressive disclosure |
| [User flows](UserFlows.md) | User flows, journey maps, task analysis, onboarding, recovery, power-user workflows |

## Related

- [Design philosophy](../Design/DesignPhilosophy.md) — the principles every behaviour serves (deference, calm, direct manipulation).
- [Components](../Components/README.md) — the parts these experiences compose.
- [DesktopEngine](../Architecture/DesktopEngine.md) / [WindowSystem](../Architecture/WindowSystem.md) — the engine behaviours the interaction model rests on.
- [Research/DesktopCustomizationUXResearch](../Research/DesktopCustomizationUXResearch.md) — the prior-art evidence behind these decisions.
- [ADR-0014](../Decisions/ADR-0014-direct-manipulation-widget-interaction-model.md) / [ADR-0015](../Decisions/ADR-0015-settings-information-architecture.md) — the recorded interaction and IA decisions.
