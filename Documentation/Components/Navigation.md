---
title: Navigation
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [ComponentArchitecture.md, README.md, ../UX/SettingsUX.md, ../UX/InformationArchitecture.md, ../UX/WidgetUX.md]
---

# Navigation

The components that let a user move through and act on the product: toolbars, the floating toolbar, the inspector/property panel, context menus, the Settings window and its preference panes, and the theme and wallpaper selectors. Shared state/variant meaning is in [ComponentArchitecture](ComponentArchitecture.md); placement and flow are in [UX](../UX/README.md).

## Purpose and scope

In scope: the navigation and editing-surface components. Out of scope: the information architecture they express ([UX/InformationArchitecture](../UX/InformationArchitecture.md)) and the settings content ([UX/SettingsUX](../UX/SettingsUX.md)).

## Toolbar

- **Purpose.** Contextual actions for the current surface or selection.
- **Variants.** Window toolbar (Settings) · Contextual toolbar (edit mode).
- **States.** Actions rest/hover/pressed/disabled; overflow when narrow.
- **Accessibility.** Each item labelled; standard toolbar semantics; keyboard-reachable.
- **Animation.** Appears with edit mode (`motion.default`).
- **Guidelines.** Few, high-value actions; native toolbar look; overflow rather than crowding.

## Floating Toolbar

- **Purpose.** A small, contextual action cluster near a selected widget (align, layer, lock, configure).
- **Variants.** Anchored to selection · Pinned.
- **States.** Hidden · Appearing · Visible (follows selection) · Dismissing.
- **Sizing.** Compact; `control` radius; `blur` material to separate from busy content.
- **Accessibility.** Focusable group; actions labelled; Escape dismisses; does not trap focus.
- **Keyboard.** Reachable from the selected widget; arrow/Tab through actions.
- **Animation.** `motion.fast` appear near the selection; repositions smoothly as selection moves.
- **Guidelines.** Appears only with a selection; never obscures what it acts on; quiet at rest.

## Inspector / Property Panel

- **Purpose.** Edit the selected widget's properties (size, position, data source, appearance, refresh).
- **Variants.** Docked panel · Floating panel.
- **States.** Empty (no selection) · Single selection · Multi-selection (common properties) · Configuring.
- **Sizing.** Standard inspector width with a minimum; built on Glass Panel.
- **Spacing.** Form rhythm: aligned label column, 8-pt rows, `m` insets.
- **Accessibility.** Logical reading/focus order top-to-bottom; controls labelled; changes announced.
- **Keyboard.** Tab through fields; standard form navigation; live or apply-on-commit per field.
- **Animation.** Show/hide `motion.default`; field changes `motion.fast`.
- **Performance.** Reflects the selected widget via observation; no polling.
- **Guidelines.** Progressive disclosure — common properties first, advanced behind a disclosure ([UX/InformationArchitecture](../UX/InformationArchitecture.md)).

## Context Menu

- **Purpose.** Right-click actions on a widget or the canvas (configure, duplicate, layer, lock, remove; add-widget on canvas).
- **Variants.** Widget menu · Canvas menu · with submenus.
- **States.** Item rest/hover/disabled; submenu open.
- **Accessibility.** Native menu semantics; keyboard-openable (Ctrl-Return / menu key); type-ahead.
- **Keyboard.** Opens via keyboard; arrows navigate; Escape closes.
- **Guidelines.** Use the native menu; mirror the most common actions that also exist in the floating toolbar; keep it short.

## Settings Window / Preference Pane

- **Purpose.** The app's configuration surface ([UX/SettingsUX](../UX/SettingsUX.md)).
- **Variants.** Sidebar + detail (primary) · Search-driven results.
- **States.** Pane selected · Searching · Editing · Restored-on-reopen.
- **Sizing.** Resizable with a minimum; sidebar + detail; standard macOS settings metrics.
- **Accessibility.** Sidebar is a source list; panes have logical focus order; search is keyboard-first.
- **Keyboard.** Cmd-, opens; Cmd-F searches; arrows navigate the sidebar.
- **Animation.** Pane switch `motion.fast`; no disorienting transitions.
- **Guidelines.** Standard macOS Settings pattern; default to less, advanced behind disclosure; never a wall of options.

## Theme Selector & Wallpaper Selector

- **Purpose.** Galleries for choosing appearance (theme) and wallpaper ([UX/WallpaperUX](../UX/WallpaperUX.md), [Design/ThemeArchitecture](../Design/ThemeArchitecture.md)).
- **Variants.** Theme swatch gallery · Wallpaper thumbnail gallery (categorised).
- **States.** Browsing · Selected (applied live) · Loading thumbnails · Empty/No-results.
- **Sizing.** Adaptive grid of fixed-min-width cells reflowing by width ([LayoutAndSpacing](../Design/LayoutAndSpacing.md)).
- **Accessibility.** Each cell labelled (name, not preview alone); selection has a shape/border cue; keyboard-navigable grid.
- **Keyboard.** Arrow-navigate; Return applies; live preview on focus.
- **Animation.** Selection `motion.fast`; wallpaper applies with `slow` cross-fade ([MotionSystem](../Design/MotionSystem.md)).
- **Performance.** Thumbnails lazy-loaded and cached; previews are downscaled, not full-res ([WallpaperUX](../UX/WallpaperUX.md)).
- **Guidelines.** Preview live but reversibly; make "revert" obvious; show source/attribution where relevant.

## Trade-offs

- Mirroring actions across context menu, floating toolbar, and inspector adds redundancy; intentional — different users reach for different affordances, and consistency across them is the rule.
- Standard Settings pattern forgoes a novel configuration UX; deliberate, for familiarity.

## Future evolution

The inspector grows multi-select editing and alignment tooling; the wallpaper/theme galleries extend to the marketplace ([Marketplace](Marketplace.md)). A command palette over settings/actions is a natural power-user addition ([UX/UserFlows](../UX/UserFlows.md)).

## Open questions

- Whether the inspector should be a single docked panel or summonable per-widget floating panel by default.

## References

1. [ComponentArchitecture](ComponentArchitecture.md) · [UX/SettingsUX](../UX/SettingsUX.md) · [UX/WidgetUX](../UX/WidgetUX.md) · [Design/ThemeArchitecture](../Design/ThemeArchitecture.md).
2. Apple, "HIG — Toolbars / The menu bar / Settings." https://developer.apple.com/design/human-interface-guidelines/

## Completion checklist
- [x] Navigation/editing components specified against the schema.
- [x] Keyboard and accessibility per component stated.
- [x] Progressive-disclosure and native-pattern rules noted.

## Review checklist
- [ ] Reconciled with SettingsUX and InformationArchitecture.
- [ ] Action parity across menu/toolbar/inspector verified.
- [ ] Meets DocumentationStandards.
