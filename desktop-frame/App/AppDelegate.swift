import AppKit

/// AppKit delegate that bootstraps the Desktop Frame engine stack.
///
/// SwiftUI's `App` protocol handles the settings window; everything else —
/// desktop windows, engine startup, and global event monitoring — lives here
/// so we have full AppKit control without fighting SwiftUI's scene lifecycle.
@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Lifecycle

    func applicationDidFinishLaunching(_ notification: Notification) {
        configureApplication()
        AppLogger.engine.info("Desktop Frame launched (v\(AppConstants.App.version, privacy: .public))")
    }

    func applicationWillTerminate(_ notification: Notification) {
        AppLogger.engine.info("Desktop Frame terminating")
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        // The app must keep running even when all windows are closed;
        // the desktop layer window is not a "normal" window.
        false
    }

    // MARK: - Private

    private func configureApplication() {
        // Prevent the default empty window from appearing on first launch.
        NSApp.setActivationPolicy(.accessory)
    }
}
