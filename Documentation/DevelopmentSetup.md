# Desktop Frame — Development Setup

## Requirements

| Tool       | Minimum Version | Notes |
|------------|-----------------|-------|
| macOS      | 15.0 Sequoia    | `@Observable`, Swift 6 runtime |
| Xcode      | 16.0            | Swift 6 toolchain, `PBXFileSystemSynchronizedRootGroup` |
| Swift      | 6.0             | Strict concurrency |

## First-Time Setup

```bash
# 1. Clone the repository
git clone https://github.com/yourorg/desktop-frame.git
cd desktop-frame

# 2. Open in Xcode (no `pod install` or `swift package resolve` required yet)
open desktop-frame.xcodeproj
```

No additional tooling is required at this stage. SPM packages will be added as needed; they resolve automatically on first build.

## Build Configurations

| Configuration | Purpose |
|---------------|---------|
| `Debug`       | Development — verbose logging, debug overlay enabled |
| `Release`     | Distribution — optimised, no debug symbols |

## Running the App

1. Select the `desktop-frame` scheme and a macOS destination.
2. Press **⌘R**.
3. The app runs as a menu-bar accessory (no Dock icon). Open **Desktop Frame** from the status bar or press **⌘,** for Settings.

## Swift Strict Concurrency

The project compiles with `SWIFT_STRICT_CONCURRENCY = complete`. All concurrency warnings are treated as errors. When adding new code:

- Mark service types `actor`.
- Mark UI-facing types `@MainActor`.
- Ensure cross-boundary value types conform to `Sendable`.

## OSLog Viewing

Open **Console.app** and filter by subsystem `com.desktopframe.app` to see structured log output from all engine categories.

## Code Style

Run SwiftFormat before committing:

```bash
swift-format format --in-place --recursive desktop-frame/
```

Configuration lives in `.swift-format` at the repository root (to be added).
