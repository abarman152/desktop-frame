# Desktop Frame — Architecture

## Overview

Desktop Frame is structured as a layered, protocol-driven macOS application. The goal is Apple-quality engineering: every layer has a single, well-defined responsibility and depends on abstractions rather than concrete types.

```
┌─────────────────────────────────────────────────────────┐
│                        App Layer                        │
│     DesktopFrameApp  ·  AppDelegate  ·  Settings        │
├─────────────────────────────────────────────────────────┤
│                     Feature Layer                       │
│  Desktop  ·  Widgets  ·  Wallpaper  ·  Calendar  …     │
├─────────────────────────────────────────────────────────┤
│                      Core Layer                         │
│  Engines  ·  Managers  ·  Services  ·  Window System   │
├─────────────────────────────────────────────────────────┤
│                   Foundation Layer                      │
│        Models  ·  Utilities  ·  Extensions              │
└─────────────────────────────────────────────────────────┘
```

---

## Key Design Decisions

### 1. AppKit Window, SwiftUI Content

The desktop-layer window (`DesktopWindow`) is an `NSWindow` subclass because `WindowGroup` cannot set an arbitrary `CGWindowLevel`. The window's _content_ is rendered by SwiftUI via `NSHostingView`, giving us native declarative layout with full AppKit window control.

### 2. Actors for Services, `@MainActor` for Managers

System-metric services (`CPUService`, `MemoryService`, etc.) are Swift `actor` types. Data is fetched off the main thread and published to `@MainActor`-isolated managers via `async/await`. This eliminates data races by construction in Swift 6 strict-concurrency mode.

### 3. `@Observable` over `ObservableObject`

All state types use the `@Observable` macro (Swift 5.9+) rather than `ObservableObject`. This gives fine-grained property-level invalidation, reducing unnecessary SwiftUI view updates.

### 4. Protocol-First Engines

Every engine exposes a protocol (`DesktopEngineProtocol`, `WidgetEngineProtocol`, …) before a concrete type. This enables:
- Unit testing with mock implementations.
- Future plugin injection via the `Plugins/` module.
- Clean separation between interface and implementation.

### 5. Dependency Injection via Initialiser

Concrete types receive their dependencies through initialiser parameters. There is no global service locator. `AppDelegate` composes the object graph on launch.

---

## Concurrency Model

```
Main Thread (@MainActor)
│
├── AppDelegate          — AppKit lifecycle
├── WindowManager        — NSWindow creation / disposal
├── WidgetManager        — widget lifecycle, layout state
├── DesktopEngine        — coordinates managers
│
└── SwiftUI render tree  — all Views

Background (actor isolation)
│
├── CPUService           — host_statistics64 polling
├── MemoryService        — vm_statistics64 polling
├── NetworkService       — NWPathMonitor / throughput
├── BatteryService       — IOKit power source
├── StorageService       — FileManager volume attributes
├── CalendarService      — EventKit async fetch
└── ReminderService      — EventKit async fetch
```

Data flows upward: actors publish via `AsyncStream` → managers consume on `@MainActor` → SwiftUI observes changes.

---

## Module Ownership

| Module            | Owner               | Key Types                                   |
|-------------------|---------------------|---------------------------------------------|
| `Core/Engine`     | Engine team         | `DesktopEngine`, `WidgetEngine`             |
| `Core/Managers`   | Engine team         | `WindowManager`, `MonitorManager`           |
| `Core/Services`   | Platform team       | `CPUService`, `CalendarService`             |
| `Core/Window`     | Platform team       | `DesktopWindow`, `OverlayWindow`            |
| `Features/*`      | Feature teams       | Per-feature Views + ViewModels              |
| `Models`          | Shared              | `Widget`, `DesktopLayout`, `Theme`          |
| `Plugins`         | Plugin team         | Plugin protocol + sandbox                   |
