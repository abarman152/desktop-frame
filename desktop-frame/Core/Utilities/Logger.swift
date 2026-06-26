import os.log

/// Centralised OSLog loggers for Desktop Frame.
///
/// Usage:
/// ```swift
/// AppLogger.engine.info("DesktopEngine started")
/// AppLogger.widgets.error("Widget \(id) failed to load")
/// ```
public enum AppLogger {

    // MARK: - Subsystem

    static let subsystem: String = Bundle.main.bundleIdentifier ?? "com.desktopframe.app"

    // MARK: - Categories

    /// Engine-layer events: startup, teardown, main loop ticks.
    static let engine     = Logger(subsystem: subsystem, category: "Engine")

    /// Widget lifecycle: load, update, remove.
    static let widgets    = Logger(subsystem: subsystem, category: "Widgets")

    /// Rendering pipeline: frame timing, GPU submission, layer compositing.
    static let rendering  = Logger(subsystem: subsystem, category: "Rendering")

    /// Window management: creation, level changes, monitor mapping.
    static let window     = Logger(subsystem: subsystem, category: "Window")

    /// System service polling: CPU, memory, battery, network.
    static let services   = Logger(subsystem: subsystem, category: "Services")

    /// Wallpaper transitions and asset loading.
    static let wallpaper  = Logger(subsystem: subsystem, category: "Wallpaper")

    /// Settings persistence reads and writes.
    static let settings   = Logger(subsystem: subsystem, category: "Settings")

    /// Calendar and reminder data synchronisation.
    static let calendar   = Logger(subsystem: subsystem, category: "Calendar")

    /// Plugin loading, sandboxing, and lifecycle.
    static let plugins    = Logger(subsystem: subsystem, category: "Plugins")

    /// Permission requests and authorisation state.
    static let permissions = Logger(subsystem: subsystem, category: "Permissions")
}
