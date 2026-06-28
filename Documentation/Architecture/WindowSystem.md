---
title: Window system architecture
status: Active
owner: Window System
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [Architecture.md, MultiMonitorArchitecture.md, DesktopEngine.md, ../Decisions/ADR-0001-appkit-window-swiftui-content.md, ../Research/MacOSPlatformResearch.md, ../../.agents/WINDOW_SYSTEM_AGENT.md]
---

# Window system architecture

The window system is the foundation everything else renders into: the `NSWindow` subclasses that place Desktop Frame's content at the right level, on the right display, across the right Spaces, without stealing focus or breaking Finder. It is the subsystem most exposed to macOS's window-server behaviour, much of which is observed rather than contractual; claims here are labelled accordingly and detailed in [MacOSPlatformResearch](../Research/MacOSPlatformResearch.md).

## Purpose and scope

In scope: the window hierarchy and levels, transparent/overlay windows, behaviour across Mission Control, Stage Manager, Spaces and multiple desktops, full-screen apps, external displays and hot-plugging, and focus/accessibility handling at the window layer. Out of scope: what is drawn inside the windows ([RenderingEngine](RenderingEngine.md)), input semantics ([DesktopEngine](DesktopEngine.md)), and display-identity/layout binding ([MultiMonitorArchitecture](MultiMonitorArchitecture.md)).

## Context

A desktop layer is not a normal app window. It must sit behind Finder icons (for the wallpaper/widget surface) or above app windows (for the overlay), appear on the Spaces the user chose, never become key unless the user is interacting with a widget, and survive the user dragging a monitor's worth of windows around. SwiftUI scenes cannot express any of that, which is why the window layer is AppKit ([ADR-0001](../Decisions/ADR-0001-appkit-window-swiftui-content.md)). The scaffolding already encodes the two levels and keeps the app running with no standard windows (`applicationShouldTerminateAfterLastWindowClosed` returns `false`, accessory activation policy).

## Design

### Window types and hierarchy

```
NSWindow (AppKit)
├── DesktopWindow      level = desktopIconWindow − 1   one per active display
│     └── NSHostingView → SwiftUI desktop surface (wallpaper + widgets)
├── OverlayWindow      level = floatingWindow          dashboard / HUD, on demand
│     └── NSHostingView → SwiftUI overlay surface
└── (Settings)         standard SwiftUI Settings scene  ⌘, preferences
```

Window hierarchy. Two AppKit subclasses host SwiftUI content at fixed levels; the only standard window is the Settings scene.

- **`DesktopWindow`** — the always-on surface. One instance per active display ([ADR-0009](../Decisions/ADR-0009-per-display-independent-layouts.md)). `level = AppConstants.Window.desktopLevel` (one below `desktopIconWindow`), `isOpaque = false`, clear background, `collectionBehavior` chosen so it appears on all Spaces and is ignored by Mission Control's window management, `ignoresMouseEvents` toggled by interaction mode (see [DesktopEngine](DesktopEngine.md)).
- **`OverlayWindow`** — an on-demand layer above app windows (`level = overlayLevel`, `floatingWindow`) for a dashboard or HUD. Non-activating so summoning it does not deactivate the user's foreground app.
- **Settings** — the one standard window, owned by SwiftUI's `Settings` scene.

### Window levels

`CGWindowLevel` is an integer; the desktop surface is pinned relative to the Finder icon level so icons stay on top and interactive (the named invariant), and the overlay floats above normal windows. Both are constants in `AppConstants.Window`, computed from `CGWindowLevelForKey` rather than hard-coded magic numbers, so they track Apple's keyed levels.

### Collection behaviour, Spaces, and full-screen

The window's `collectionBehavior` is where Spaces and Mission Control behaviour is configured: `.canJoinAllSpaces` (or `.moveToActiveSpace`), `.stationary` so the surface does not slide in Mission Control, and `.ignoresCycle` so it stays out of `⌘\`` window cycling. Whether widgets appear over full-screen apps is the user setting `AppConfiguration.showWidgetsOnAllSpaces`, implemented through collection behaviour. *(Inference: the exact flag combination that yields "always present, never managed, doesn't fight Mission Control" is determined empirically in the window milestone; the candidate set and observed behaviour are recorded in [MacOSPlatformResearch](../Research/MacOSPlatformResearch.md).)*

### Stage Manager and Mission Control

Stage Manager (macOS 13+) reorganises app windows but treats the desktop and wallpaper as background; the desktop surface should read as background, not as a staged window. Mission Control similarly should not pick up the surface as a managed window. Both are governed by collection behaviour and window level. *(Inference: Stage Manager's treatment of a non-activating desktop-level window is observed, not documented as contractual; tracked in research and re-verified per macOS release.)*

### External displays and hot-plugging

One `DesktopWindow` per active display. On a display-configuration change the window system reconciles the set of windows to the set of present displays — creating a window for a newly attached display, tearing down the window for a removed one, and re-homing each surviving window to its display's frame — then hands display-identity and layout binding to [MultiMonitorArchitecture](MultiMonitorArchitecture.md). The trigger is `NSApplication.didChangeScreenParametersNotification`, fanned out as `AppConstants.Notifications.monitorConfigurationChanged`.

### Focus and accessibility

The surface is non-activating by default: scrolling past it or clicking through it must not steal key-window status from the user's foreground app. When a widget genuinely needs input (a text field, a button), the window becomes key only for that interaction and yields it back. At the window layer, the surface participates in the accessibility tree so VoiceOver can reach widgets; the per-widget accessibility contract is in [WidgetEngine](WidgetEngine.md) and governed by [AccessibilityStandards](../Standards/AccessibilityStandards.md). The `appkit-bridge` patterns (NSPanel non-activating styles, `NSWindow` configuration) apply throughout.

## Invariants

1. **The desktop surface stays below `desktopIconWindow`;** Finder icons remain visible and clickable ([ADR-0001](../Decisions/ADR-0001-appkit-window-swiftui-content.md)).
2. **The surface does not steal key/focus** from the foreground app except during explicit widget interaction.
3. **Exactly one `DesktopWindow` exists per active display,** reconciled on every configuration change.
4. **Window-level concerns live in AppKit**, content in SwiftUI; features never create windows.

## Data flow

Display-parameter changes enter as an AppKit notification, are reconciled into the window set, and emit `monitorConfigurationChanged`. Interaction-mode changes (interactive vs click-through) toggle `ignoresMouseEvents`. Nothing else mutates window state; the windows are otherwise static hosts for their SwiftUI content.

## Alternatives and decisions

The AppKit-window/SwiftUI-content split is [ADR-0001](../Decisions/ADR-0001-appkit-window-swiftui-content.md). The one-window-per-display model is [ADR-0009](../Decisions/ADR-0009-per-display-independent-layouts.md). Private window-server APIs were rejected by [ADR-0001](../Decisions/ADR-0001-appkit-window-swiftui-content.md) and [SecurityStandards](../Standards/SecurityStandards.md).

## Known limitations

- Several behaviours (Mission Control, Stage Manager, full-screen overlay) depend on observed window-server behaviour that Apple does not contract; they are verified empirically and re-checked each macOS release. This is the subsystem with the highest such exposure.
- Screen-recording/Screen-Sharing interaction (`hideWidgetsDuringScreenShare`) needs the screen-capture detection path defined during the window milestone.

## Future evolution

If a future macOS removes or changes the keyed window levels the surface depends on, the constants in `AppConstants.Window` are the single point of adaptation. The non-activating overlay is the seam through which richer HUD/command experiences arrive without changing the desktop surface.

## Open questions

- The precise `collectionBehavior` set for "present on all Spaces including full-screen, invisible to Mission Control management, ignored by window cycling" — finalised empirically in the window milestone.
- Whether the overlay should be a single window or per-display, like the desktop surface.

## References

1. Apple, "NSWindow." https://developer.apple.com/documentation/appkit/nswindow
2. Apple, "NSWindow.CollectionBehavior." https://developer.apple.com/documentation/appkit/nswindow/collectionbehavior
3. [WINDOW_SYSTEM_AGENT](../../.agents/WINDOW_SYSTEM_AGENT.md) · [MacOSPlatformResearch](../Research/MacOSPlatformResearch.md).

## Completion checklist
- [x] Window types, levels, and hierarchy described.
- [x] Spaces / Mission Control / Stage Manager / full-screen behaviour addressed.
- [x] External-display and hot-plug reconciliation described.
- [x] Focus and accessibility at the window layer stated.
- [x] Invariants named; ADRs linked; observed-vs-contractual claims labelled.

## Review checklist
- [ ] Matches the `DesktopWindow`/`OverlayWindow` implementation.
- [ ] Observed behaviours re-verified on the current macOS.
- [ ] Meets DocumentationStandards.
