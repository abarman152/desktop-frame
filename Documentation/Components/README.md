---
title: Component library index
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [ComponentArchitecture.md, ../Design/README.md, ../UX/README.md, ../Design/EngineeringHandoff.md]
---

# Component library index

The catalogue of every reusable UI component in Desktop Frame, grouped by family. Each component is built from [design tokens](../Design/DesignTokens.md), specified once here, and implemented against the [engineering handoff](../Design/EngineeringHandoff.md). Components are documented as *architecture* — purpose, variants, states, behaviour — not as production code. The shared model (anatomy, variants, states, naming, composition) is in [ComponentArchitecture](ComponentArchitecture.md).

## How to read a component

Every component is specified with the same schema:

**Purpose · Usage · Variants · States · Sizing · Spacing · Accessibility · Keyboard · Animation · Performance · Design guidelines · Future evolution.**

The shared meaning of *states* (rest/hover/pressed/selected/focused/disabled/loading/empty/error) and *variants* is defined once in [ComponentArchitecture](ComponentArchitecture.md); a component doc only notes where it differs.

## Families

| Family | Components | Doc |
|---|---|---|
| Surfaces | Desktop Canvas, Glass Panel, Widget Container, Widget Card, Dashboard Panel, Sidebar | [Surfaces](Surfaces.md) |
| Controls | Buttons, Segmented Control, Dropdown/Menu, Slider, Color Picker, Icon Picker, Search Bar & Results | [Controls](Controls.md) |
| Navigation | Toolbar, Floating Toolbar, Inspector / Property Panel, Context Menu, Settings Window / Preference Pane, Theme Selector, Wallpaper Selector | [Navigation](Navigation.md) |
| Overlays | Dialog, Sheet, Popover, Notification Banner, Progress Indicators | [Overlays](Overlays.md) |
| Data & charts | Metric Card, CPU / Memory / Battery / Network graphs | [DataAndCharts](DataAndCharts.md) |
| Widgets | Calendar, Reminder, Weather, Clock widget content | [Widgets](Widgets.md) |
| States & feedback | Empty, Loading, Error, Skeleton, Onboarding components | [StatesAndFeedback](StatesAndFeedback.md) |
| Marketplace | Plugin Card, Marketplace Card | [Marketplace](Marketplace.md) |

## Master catalogue

| Component | Family | Primary use |
|---|---|---|
| Desktop Canvas | Surfaces | The full-desktop interactive surface that hosts widgets |
| Glass Panel | Surfaces | The base translucent container all panels are built on |
| Widget Container | Surfaces | The chrome (frame, handles, selection) around any widget |
| Widget Card | Surfaces | The standard widget body: header, content, footer |
| Dashboard Panel | Surfaces | The summon-able overlay aggregating widgets |
| Sidebar | Surfaces | The navigation column in Settings and the Dashboard |
| Button | Controls | All action triggers (primary/secondary/tertiary/icon/destructive) |
| Segmented Control | Controls | Mutually-exclusive choice among 2–5 options |
| Dropdown / Menu | Controls | A choice from a longer list; contextual actions |
| Slider | Controls | A continuous or stepped value |
| Color Picker | Controls | Theme accent / colour-token selection |
| Icon Picker | Controls | Choosing an SF Symbol for a widget/shortcut |
| Search Bar & Results | Controls | Searching settings, widgets, the marketplace |
| Toolbar / Floating Toolbar | Navigation | Contextual actions for the surface or a selection |
| Inspector / Property Panel | Navigation | Editing the selected widget's properties |
| Context Menu | Navigation | Right-click actions on a widget or the canvas |
| Settings Window / Preference Pane | Navigation | The app's configuration surface |
| Theme / Wallpaper Selector | Navigation | Galleries for choosing appearance and wallpaper |
| Dialog / Sheet / Popover | Overlays | Modal and transient surfaces |
| Notification Banner | Overlays | Quiet, dismissible system messages |
| Progress Indicators | Overlays | Determinate and indeterminate progress |
| Metric Card | Data & charts | A single system metric with sparkline |
| CPU/Memory/Battery/Network graph | Data & charts | Live time-series of a system metric |
| Calendar/Reminder/Weather/Clock | Widgets | The built-in information widgets |
| Empty/Loading/Error/Skeleton | States & feedback | The non-happy-path surfaces |
| Onboarding components | States & feedback | First-run guidance |
| Plugin / Marketplace Card | Marketplace | Discovering and managing third-party widgets |

## Related

- [Design system](../Design/README.md) — the tokens every component consumes.
- [UX](../UX/README.md) — how these components behave in flows and interactions.
- [Engineering handoff](../Design/EngineeringHandoff.md) — SwiftUI/AppKit guidance per family.
- [UISpecification template](../Templates/UISpecification.md) — the per-feature spec that composes these components.
