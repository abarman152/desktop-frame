---
title: ADR-0001 AppKit window host with SwiftUI content at the desktop level
status: Accepted
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-12-27
related: [ADR-0003-observable-state-model.md, ../Architecture/WindowSystem.md, ../Architecture/RenderingEngine.md]
---

# ADR-0001: AppKit window host with SwiftUI content at the desktop level

## Status

Accepted — 2026-06-27. Back-fills a decision made during scaffolding.

## Context

Desktop Frame renders a live layer behind the user's app windows and, separately, an overlay layer above them. That layer must sit at a precise `CGWindowLevel`: behind Finder's desktop icons for the wallpaper-and-widget surface, and above normal windows for the dashboard overlay. The scaffolding already encodes this in `AppConstants.Window.desktopLevel` (`desktopIconWindow − 1`) and `overlayLevel` (`floatingWindow`).

SwiftUI's `WindowGroup` and `Window` scenes do not expose `level`, `collectionBehavior`, `ignoresMouseEvents`, or `sharingType`. They also create document-style windows with standard chrome and activation behaviour, which is wrong for a desktop layer. AppKit's `NSWindow` exposes all of these directly. The app entry point (`DesktopFrameApp`) is therefore deliberately thin: a `Settings` scene plus an `@NSApplicationDelegateAdaptor`, with `NSApp.setActivationPolicy(.accessory)` so no default window appears.

## Problem

How do we obtain arbitrary window-level, Space-collection, and event-transparency control while still authoring the layer's content in SwiftUI?

## Alternatives considered

1. **Pure SwiftUI scenes.** Simplest, but cannot set window level or collection behaviour. Disqualifying: the desktop level is the product.
2. **Pure AppKit views (`NSView`/Core Animation) for content.** Full control, but discards SwiftUI's declarative layout, state binding, and the team's SwiftUI investment; slower to build widgets.
3. **AppKit `NSWindow` subclass hosting SwiftUI via `NSHostingView`.** Native window control with declarative content. The standard bridge for exactly this gap.
4. **Private window-server APIs (`CGSConnection`).** More control still, but private API is forbidden by [SecurityStandards](../Standards/SecurityStandards.md) and risks App Review and OS-version breakage.

## Decision

Adopt option 3. The desktop and overlay windows are `NSWindow` subclasses (`DesktopWindow`, `OverlayWindow`) owned by `Core/Window/`. Their content is a SwiftUI hierarchy hosted in an `NSHostingView`. Window-level concerns (level, `collectionBehavior`, `ignoresMouseEvents`, `sharingType`, `isOpaque`, `backgroundColor = .clear`) are configured in AppKit; everything inside the content rectangle is SwiftUI. The `AppDelegate` composes and owns these windows; the SwiftUI `App` struct stays thin and never owns the desktop layer. Decided by the founding engineering team.

## Trade-offs

We accept a bridging seam (`NSHostingView`) and the discipline of keeping window concerns in AppKit and content concerns in SwiftUI. In exchange we get exact window control and declarative content without re-implementing layout. The seam is well-trodden and documented by Apple; the `appkit-bridge` skill captures the patterns.

## Consequences

- `Core/Window/` owns the only `NSWindow` subclasses; features never create windows.
- The invariant **the desktop surface renders below `desktopIconWindow` so Finder icons stay interactive** is owned here and enforced by `AppConstants.Window.desktopLevel`.
- SwiftUI content cannot assume standard window chrome, key-window focus, or first-responder defaults; the window layer supplies these explicitly. See [WindowSystem](../Architecture/WindowSystem.md).
- Hit-testing and event routing across the AppKit/SwiftUI seam need explicit design (overlay click-through, widget drag); covered in [DesktopEngine](../Architecture/DesktopEngine.md).

## References

1. Apple, "NSHostingView." https://developer.apple.com/documentation/swiftui/nshostingview
2. Apple, "NSWindow.Level." https://developer.apple.com/documentation/appkit/nswindow/level
