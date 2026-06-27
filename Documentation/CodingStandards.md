# Desktop Frame — Coding Standards

## Language

- **Swift 6**, strict concurrency enabled (`SWIFT_STRICT_CONCURRENCY = complete`).
- No Objective-C new code. AppKit bridging uses `NSViewRepresentable` / `NSHostingView`.

## Concurrency

| Type | Rule |
|------|------|
| System-data services | `actor` — never touch AppKit/UIKit |
| UI managers | `@MainActor final class` |
| SwiftUI Views | Implicitly `@MainActor` — no annotation needed |
| Value types passed across actors | Must conform to `Sendable` |
| Cross-actor calls | `await` — never `DispatchQueue.main.async` |

## State

- Use `@Observable` (Swift 5.9+), not `ObservableObject`.
- Prefer `let` over `var` everywhere possible.
- Avoid `@State` in non-leaf views — push state up to a ViewModel or manager.

## Naming

- Types: `UpperCamelCase` — `DesktopEngine`, `WidgetPosition`.
- Functions / properties: `lowerCamelCase` — `startEngine()`, `currentLayout`.
- Constants: `lowerCamelCase` inside a `case`-less `enum` — `AppConstants.Widget.snapGrid`.
- Notifications: reverse-DNS string — `"DesktopFrame.themeDidChange"`.
- Protocol names: noun or `-able`/`-Protocol` suffix — `WidgetRenderable`, `DesktopEngineProtocol`.

## File Layout

```swift
// MARK: - Imports (alphabetical)
import AppKit
import Foundation
import SwiftUI

// MARK: - Type Declaration

/// One-line summary sentence.
///
/// Longer description if required. Explains *why*, not *what*.
public final class MyType {

    // MARK: - Properties
    // MARK: - Init
    // MARK: - Public Interface
    // MARK: - Private Helpers
}

// MARK: - Protocol Conformances (one extension per protocol)

extension MyType: Equatable { … }
```

## Comments

- Write a `///` doc comment on every `public` and `internal` declaration.
- Explain *why*, not *what* — the code already says *what*.
- No `// TODO:` in committed code. Open a GitHub issue instead.
- No `// MARK:` sections with fewer than two members.

## SwiftUI Views

- Keep `body` under ~30 lines; extract `private` sub-views or `ViewBuilder` properties.
- Pass dependencies through the view initialiser, not through `@EnvironmentObject` unless the dependency is truly environment-wide.
- Add `.accessibilityLabel` and `.accessibilityHint` to all interactive elements.

## Testing

- Services: unit-test with a mock `Clock` / mock `URLSession`.
- Managers: integration-test against real AppKit on macOS.
- No `@testable import` in tests that exercise public API — design public interfaces properly.

## Git

- Commits: imperative mood, ≤72 characters — `Add MonitorManager screen-change handler`.
- One logical change per commit; squash WIP commits before merging.
- Branch naming: `feature/widget-engine`, `fix/memory-leak-desktop-window`.
