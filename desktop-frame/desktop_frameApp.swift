import SwiftUI

/// Desktop Frame application entry point.
///
/// The SwiftUI `App` struct is intentionally thin — it attaches the `AppDelegate`
/// for AppKit lifecycle control and exposes a `Settings` scene for the preferences
/// window. All engine startup and window management happens inside `AppDelegate`.
@main
struct DesktopFrameApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // The Settings scene gives users a standard ⌘, preferences window
        // without requiring a WindowGroup (which would create an unwanted
        // document-style window on launch).
        Settings {
            SettingsPlaceholderView()
        }
    }
}

// MARK: - Settings Placeholder

/// Temporary settings root; replaced in the Settings feature milestone.
private struct SettingsPlaceholderView: View {
    var body: some View {
        Text("Settings coming soon")
            .frame(width: 480, height: 320)
    }
}
