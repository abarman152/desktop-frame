import Foundation
import SwiftUI

/// Runtime configuration for Desktop Frame.
///
/// Backed by a dedicated `UserDefaults` suite so settings are isolated from
/// other apps sharing the same container. All properties are `@MainActor`
/// because they drive SwiftUI observation.
///
/// Access the singleton via `AppConfiguration.shared`.
@MainActor
@Observable
public final class AppConfiguration {

    // MARK: - Singleton

    public static let shared = AppConfiguration()

    // MARK: - Backing Store

    private let defaults: UserDefaults

    // MARK: - Display

    /// Widgets appear on every Space, including full-screen apps.
    public var showWidgetsOnAllSpaces: Bool {
        didSet { defaults.set(showWidgetsOnAllSpaces, forKey: Keys.showWidgetsOnAllSpaces) }
    }

    /// Automatically hide widgets while screen sharing is active.
    public var hideWidgetsDuringScreenShare: Bool {
        didSet { defaults.set(hideWidgetsDuringScreenShare, forKey: Keys.hideWidgetsDuringScreenShare) }
    }

    /// Render at the display's native resolution on HiDPI screens.
    public var enableHighDPIRendering: Bool {
        didSet { defaults.set(enableHighDPIRendering, forKey: Keys.enableHighDPIRendering) }
    }

    // MARK: - Performance

    /// Base polling interval for system-metric widgets (seconds).
    public var widgetRefreshInterval: TimeInterval {
        didSet { defaults.set(widgetRefreshInterval, forKey: Keys.widgetRefreshInterval) }
    }

    /// Caps how many widgets may update concurrently to avoid frame drops.
    public var maxConcurrentWidgetUpdates: Int {
        didSet { defaults.set(maxConcurrentWidgetUpdates, forKey: Keys.maxConcurrentWidgetUpdates) }
    }

    /// Use Metal/Core Animation hardware acceleration for rendering.
    public var enableHardwareAcceleration: Bool {
        didSet { defaults.set(enableHardwareAcceleration, forKey: Keys.enableHardwareAcceleration) }
    }

    // MARK: - Behaviour

    /// Register Desktop Frame as a Login Item.
    public var launchAtLogin: Bool {
        didSet { defaults.set(launchAtLogin, forKey: Keys.launchAtLogin) }
    }

    /// Show the status bar icon in the menu bar.
    public var showMenuBarIcon: Bool {
        didSet { defaults.set(showMenuBarIcon, forKey: Keys.showMenuBarIcon) }
    }

    /// Enable system-wide keyboard shortcuts for showing/hiding Desktop Frame.
    public var enableGlobalShortcuts: Bool {
        didSet { defaults.set(enableGlobalShortcuts, forKey: Keys.enableGlobalShortcuts) }
    }

    // MARK: - Debug

    /// Overlay FPS counter and layer borders on desktop widgets.
    public var showDebugOverlay: Bool {
        didSet { defaults.set(showDebugOverlay, forKey: Keys.showDebugOverlay) }
    }

    /// Emit verbose OSLog messages from all subsystems.
    public var enableVerboseLogging: Bool {
        didSet { defaults.set(enableVerboseLogging, forKey: Keys.enableVerboseLogging) }
    }

    // MARK: - Init

    private init() {
        let suite = UserDefaults(suiteName: AppConstants.Storage.suiteName) ?? .standard
        self.defaults = suite

        self.showWidgetsOnAllSpaces      = suite.optionalBool(forKey: Keys.showWidgetsOnAllSpaces)      ?? true
        self.hideWidgetsDuringScreenShare = suite.optionalBool(forKey: Keys.hideWidgetsDuringScreenShare) ?? true
        self.enableHighDPIRendering      = suite.optionalBool(forKey: Keys.enableHighDPIRendering)      ?? true
        self.widgetRefreshInterval       = suite.optionalDouble(forKey: Keys.widgetRefreshInterval)     ?? 1.0
        self.maxConcurrentWidgetUpdates  = suite.optionalInt(forKey: Keys.maxConcurrentWidgetUpdates)   ?? 8
        self.enableHardwareAcceleration  = suite.optionalBool(forKey: Keys.enableHardwareAcceleration) ?? true
        self.launchAtLogin               = suite.optionalBool(forKey: Keys.launchAtLogin)               ?? false
        self.showMenuBarIcon             = suite.optionalBool(forKey: Keys.showMenuBarIcon)             ?? true
        self.enableGlobalShortcuts       = suite.optionalBool(forKey: Keys.enableGlobalShortcuts)       ?? true
        self.showDebugOverlay            = suite.optionalBool(forKey: Keys.showDebugOverlay)            ?? false
        self.enableVerboseLogging        = suite.optionalBool(forKey: Keys.enableVerboseLogging)        ?? false
    }

    // MARK: - Keys

    private enum Keys {
        static let showWidgetsOnAllSpaces       = "showWidgetsOnAllSpaces"
        static let hideWidgetsDuringScreenShare = "hideWidgetsDuringScreenShare"
        static let enableHighDPIRendering       = "enableHighDPIRendering"
        static let widgetRefreshInterval        = "widgetRefreshInterval"
        static let maxConcurrentWidgetUpdates   = "maxConcurrentWidgetUpdates"
        static let enableHardwareAcceleration   = "enableHardwareAcceleration"
        static let launchAtLogin                = "launchAtLogin"
        static let showMenuBarIcon              = "showMenuBarIcon"
        static let enableGlobalShortcuts        = "enableGlobalShortcuts"
        static let showDebugOverlay             = "showDebugOverlay"
        static let enableVerboseLogging         = "enableVerboseLogging"
    }
}

// MARK: - UserDefaults Helpers

private extension UserDefaults {
    func optionalBool(forKey key: String) -> Bool? {
        object(forKey: key).flatMap { $0 as? Bool }
    }
    func optionalDouble(forKey key: String) -> Double? {
        object(forKey: key).flatMap { $0 as? Double }
    }
    func optionalInt(forKey key: String) -> Int? {
        object(forKey: key).flatMap { $0 as? Int }
    }
}
