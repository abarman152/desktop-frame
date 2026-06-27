# Desktop Frame — Folder Structure

```
desktop-frame/                     ← Xcode project root
│
├── desktop-frame.xcodeproj/
│
└── desktop-frame/                 ← Source root (PBXFileSystemSynchronizedRootGroup)
    │
    ├── App/
    │   └── AppDelegate.swift      — AppKit lifecycle; composes the engine graph
    │
    ├── Core/
    │   ├── Engine/                — Protocol + concrete engine types
    │   │   ├── DesktopEngine.swift
    │   │   ├── WidgetEngine.swift
    │   │   ├── LayoutEngine.swift
    │   │   ├── WallpaperEngine.swift
    │   │   └── RenderingEngine.swift
    │   │
    │   ├── Managers/              — @MainActor coordinators (touch AppKit/SwiftUI)
    │   │   ├── WindowManager.swift
    │   │   ├── MonitorManager.swift
    │   │   ├── WidgetManager.swift
    │   │   ├── SettingsManager.swift
    │   │   └── PermissionManager.swift
    │   │
    │   ├── Services/              — actor-isolated system-data providers
    │   │   ├── CPUService.swift
    │   │   ├── MemoryService.swift
    │   │   ├── StorageService.swift
    │   │   ├── BatteryService.swift
    │   │   ├── NetworkService.swift
    │   │   ├── CalendarService.swift
    │   │   └── ReminderService.swift
    │   │
    │   ├── Rendering/             — Metal / Core Animation rendering helpers
    │   │
    │   ├── Window/                — NSWindow subclasses and controllers
    │   │   ├── DesktopWindow.swift
    │   │   ├── OverlayWindow.swift
    │   │   └── DesktopWindowController.swift
    │   │
    │   ├── Utilities/
    │   │   ├── Logger.swift       — OSLog category constants
    │   │   ├── Constants.swift    — App-wide static constants
    │   │   └── AppConfiguration.swift — @Observable runtime config singleton
    │   │
    │   └── Extensions/
    │       ├── Color+Extensions.swift
    │       ├── View+Extensions.swift
    │       ├── NSWindow+Extensions.swift
    │       ├── NSScreen+Extensions.swift
    │       ├── CGSize+Extensions.swift
    │       ├── CGPoint+Extensions.swift
    │       └── NotificationCenter+Extensions.swift
    │
    ├── Features/                  — Vertical feature slices (Views + ViewModels)
    │   ├── Desktop/
    │   ├── Widgets/
    │   ├── Wallpaper/
    │   ├── Calendar/
    │   ├── Reminders/
    │   ├── Dashboard/
    │   └── Settings/
    │
    ├── Models/                    — Shared value types (Sendable structs/enums)
    │   ├── Widget.swift
    │   ├── DesktopLayout.swift
    │   ├── DesktopMonitor.swift
    │   ├── Wallpaper.swift
    │   ├── Theme.swift
    │   └── WidgetPosition.swift
    │
    ├── Views/                     — Root-level SwiftUI views (Settings shell, etc.)
    │   └── ContentView.swift
    │
    ├── Components/                — Reusable SwiftUI components shared across features
    │   ├── GlassBackground.swift
    │   ├── RoundedWidget.swift
    │   ├── AnimatedCard.swift
    │   └── MetricView.swift
    │
    ├── Themes/                    — Theme definitions and token types
    │
    ├── Plugins/                   — Plugin protocol and sandbox infrastructure
    │
    └── Resources/                 — Non-asset resources (shaders, JSON, etc.)

Documentation/                     — Markdown reference docs
Tests/                             — Unit and integration test targets
Scripts/                           — Build scripts, code generation, linting
```

## Rules

1. **Files within a layer may only import from the same layer or layers below it.**  
   Features → Core → Models/Utilities. Never the reverse.

2. **`Models/` types must be `Sendable`.**  
   Value types (structs, enums) are `Sendable` by default. Avoid classes here.

3. **`Features/` subdirectories are not allowed to import each other.**  
   Cross-feature communication goes through a Core manager or notification.

4. **One type per file.** Extensions live in `Extensions/` or alongside their type if small.
