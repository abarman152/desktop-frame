---
title: macOS platform research for the desktop layer
status: Active
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [../Architecture/WindowSystem.md, ../Architecture/RenderingEngine.md, ../Architecture/DesktopEngine.md, ../Templates/ResearchReport.md]
---

# macOS platform research for the desktop layer

The platform-behaviour evidence the window, desktop, and rendering designs rest on. A desktop-layer app lives in the least-documented corner of macOS — much of what matters is observed window-server behaviour, not contracted API — so this document is explicit about what is **verified** (documented public API), **inference** (reasoned from API but needs empirical confirmation on the target OS), and **assumption** (believed, to be tested). Each finding carries its label. Findings are re-verified per macOS release; macOS 15 is the baseline.

This is a research write-up per the [ResearchReport](../Templates/ResearchReport.md) discipline; durable findings here are mirrored in the Notion Research DB.

## Purpose and scope

In scope: the public-API surface and the observed behaviours that determine whether the desktop layer can sit behind icons, span Spaces, coexist with Mission Control / Stage Manager / full-screen, and render within budget. Out of scope: design decisions (those are ADRs and architecture docs); this is the evidence under them.

## Window level and the desktop layer

- **Verified.** `NSWindow.level` and `CGWindowLevelForKey` expose the keyed window levels, including `.desktopIconWindow`. Setting a window's level below the desktop-icon level places content behind Finder's icons. The scaffolding's `AppConstants.Window.desktopLevel` (`desktopIconWindow − 1`) uses exactly this. [1][2]
- **Verified.** `collectionBehavior` flags (`.canJoinAllSpaces`, `.stationary`, `.ignoresCycle`, `.fullScreenAuxiliary`) are public and control Spaces/Mission Control participation. [3]
- **Inference.** The *specific combination* that yields "present on every Space including over full-screen apps, never managed or moved by Mission Control, ignored by window cycling" must be confirmed empirically; the candidate set is `.canJoinAllSpaces + .stationary + .ignoresCycle`, with `.fullScreenAuxiliary` for the over-full-screen case. Confirmed in the window milestone.
- **Assumption.** A window at the desktop level with a clear background and `ignoresMouseEvents` does not interfere with Finder's desktop drag-and-drop or icon arrangement, because events never reach it. To be tested against Finder Stacks and label arrangement.

## Coexistence with system window management

- **Inference.** Stage Manager (macOS 13+) treats a non-activating desktop-level window as background rather than as a staged window; it organises *app* windows and leaves wallpaper/desktop alone. Needs confirmation on macOS 15 with Stage Manager on. [4]
- **Inference.** Mission Control will not present a `.stationary` desktop-level window as a managed thumbnail. Observed historically; re-verify per release.
- **Assumption.** Spaces switches do not destroy or reorder the per-display desktop windows; `.canJoinAllSpaces` keeps a single window visible across Spaces rather than one-per-Space. To be tested.
- **Verified.** `NSApplication.didChangeScreenParametersNotification` fires on display add/remove/rearrange/resolution change and is the correct hook for reconcile. [5]

## Finder and desktop icons

- **Verified.** Finder owns the desktop-icon window; an app cannot and should not draw the icons. Sitting below that level is the supported way to render behind them. [2]
- **Assumption.** There is no public API to read or control Finder icon positions; Desktop Frame must not attempt to, and treats icons as an opaque layer above it. Confirmed by absence of public API.
- **Inference.** Screen-recording/Screen-Sharing detection (for `hideWidgetsDuringScreenShare`) is available via `CGDisplayStream`/`SCStream` presence or the window-sharing state; the exact, sandbox-safe signal needs confirmation. [6]

## SwiftUI limitations (why AppKit owns the window)

- **Verified.** SwiftUI `WindowGroup`/`Window`/`Settings` scenes expose no API for window level, `collectionBehavior`, `ignoresMouseEvents`, or `sharingType`. This is the documented gap that forces the AppKit window with `NSHostingView` content ([ADR-0001](../Architecture/WindowSystem.md)). [7]
- **Verified.** `NSHostingView`/`NSHostingController` host SwiftUI inside AppKit windows, and `NSViewRepresentable` bridges the other way; both are public and stable. [8]
- **Inference.** SwiftUI's `Reduce Motion`, Dynamic Type, and material/vibrancy support are first-class and the right default for Tier-1 widgets; per-pixel and high-frame-rate content exceed what SwiftUI expresses efficiently, motivating the rendering tiers ([ADR-0006](../Architecture/RenderingEngine.md)).

## AppKit limitations

- **Verified.** Non-activating panels (`NSPanel` with `.nonactivatingPanel`) and `NSWindow` configuration give the focus control the overlay needs without stealing key status. [9]
- **Assumption.** Hit-testing for per-region click-through (pass most events to Finder, capture only a widget's interactive region) is achievable by overriding `NSView.hitTest(_:)` on the hosting view's container; the exact interaction with SwiftUI's own hit-testing needs a spike. This is the riskiest desktop-engine mechanic.

## Metal and rendering opportunities

- **Verified.** `CAMetalLayer`/`MTKView` and `AVPlayerLayer` with VideoToolbox hardware decode are public and are the supported path for shader and video content at low energy cost. [10][11]
- **Verified.** `ProcessInfo.thermalState` and `isLowPowerModeEnabled` (with notifications) let the wallpaper/rendering engines throttle under pressure. [12]
- **Inference.** GPU utilisation metrics are available via IOKit/Metal performance counters but the surface and fidelity vary by Apple Silicon generation; expose normalised, treat fidelity as hardware-dependent.
- **Inference.** `IOSurface` is the right primitive for sharing GPU-rendered content from an out-of-process plugin to the host compositor; the concrete design is deferred to the SDK milestone ([PluginSDK](../Architecture/PluginSDK.md)).

## Apple Human Interface Guidelines

- **Verified.** The HIG's macOS guidance — defer to the user's content, respect system appearance and accent, use SF Symbols and standard materials, honour Reduce Motion and Dynamic Type — directly supports the token-based [ThemeSystem](../Architecture/ThemeSystem.md) and the accessibility-by-default Tier-1 default. [13]
- **Judgment.** The product principle "the Mac comes first" (constitution) means the surface should feel like a native part of macOS, not a foreign skin; this biases every ambiguous call toward the platform-native option (system materials over custom blur, SF Symbols over bespoke icons).

## Future macOS compatibility

- **Judgment.** The behaviours with the highest breakage risk across macOS versions are the observed (non-contracted) ones: the exact `collectionBehavior` semantics, Stage Manager/Mission Control treatment, and full-screen overlay. Mitigation: isolate them behind `AppConstants.Window` and the window system, re-verify each behaviour per release as a checklist, and keep a conservative fallback (explicit edit mode, no per-region magic; pause-on-sleep only).
- **Assumption.** Public APIs used (window levels, EventKit, Network.framework, WeatherKit, Metal, VideoToolbox) remain available on macOS 15+; no private API is used, so App Review and OS-update risk is bounded ([SecurityStandards](../Standards/SecurityStandards.md)).

## Open investigations

These are the spikes Sprint 1 should fund before committing the affected designs (see [EngineeringReadinessAssessment](../Engineering/EngineeringReadinessAssessment.md)):

1. The exact `collectionBehavior` combination for the desktop surface across Spaces and full-screen (window milestone).
2. Per-region click-through across the SwiftUI/AppKit hosting seam (desktop-engine milestone).
3. Sandbox-safe screen-capture detection for screen-share hiding.
4. Full-occlusion detection for wallpaper pausing.
5. `IOSurface` cross-process render path for plugin Tier-3 content (SDK milestone).

## References

1. Apple, "NSWindow.Level." https://developer.apple.com/documentation/appkit/nswindow/level
2. Apple, "CGWindowLevel / Quartz Window Services." https://developer.apple.com/documentation/coregraphics/quartz_window_services
3. Apple, "NSWindow.CollectionBehavior." https://developer.apple.com/documentation/appkit/nswindow/collectionbehavior
4. Apple, "Stage Manager" (user docs; no developer contract for background-window treatment). https://support.apple.com/guide/mac-help/stage-manager
5. Apple, "didChangeScreenParametersNotification." https://developer.apple.com/documentation/appkit/nsapplication/1428625-didchangescreenparametersnotification
6. Apple, "ScreenCaptureKit." https://developer.apple.com/documentation/screencapturekit
7. Apple, "Scenes (SwiftUI)." https://developer.apple.com/documentation/swiftui/scene
8. Apple, "NSHostingView." https://developer.apple.com/documentation/swiftui/nshostingview
9. Apple, "NSPanel." https://developer.apple.com/documentation/appkit/nspanel
10. Apple, "CAMetalLayer." https://developer.apple.com/documentation/quartzcore/cametallayer
11. Apple, "VideoToolbox." https://developer.apple.com/documentation/videotoolbox
12. Apple, "ProcessInfo." https://developer.apple.com/documentation/foundation/processinfo
13. Apple, "Human Interface Guidelines — macOS." https://developer.apple.com/design/human-interface-guidelines/designing-for-macos
