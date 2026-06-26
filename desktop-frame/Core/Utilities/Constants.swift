import CoreGraphics
import Foundation

/// Application-wide constants grouped by domain.
///
/// All values are `static let` to guarantee zero-cost access after the first
/// evaluation. Avoid putting mutable state here — use `AppConfiguration` for
/// values that may change at runtime.
public enum AppConstants {

    // MARK: - App Identity

    public enum App {
        public static let name              = "Desktop Frame"
        public static let bundleIdentifier  = "com.desktopframe.app"
        public static let supportURL        = "https://desktopframe.app/support"

        public static let version: String   =
            Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        public static let build: String     =
            Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }

    // MARK: - Window Layer

    public enum Window {
        /// Sits one level below `desktopIconWindow` so Finder icons remain on top.
        public static let desktopLevel: CGWindowLevel =
            CGWindowLevel(Int32(CGWindowLevelForKey(.desktopIconWindow)) - 1)

        /// Floats above normal app windows; used for the Dashboard overlay.
        public static let overlayLevel: CGWindowLevel =
            CGWindowLevel(Int32(CGWindowLevelForKey(.floatingWindow)))

        public static let defaultCornerRadius: CGFloat  = 16
        public static let defaultPadding:      CGFloat  = 12
        public static let defaultMargin:       CGFloat  = 20
    }

    // MARK: - Widget Geometry

    public enum Widget {
        public static let minimumSize   = CGSize(width: 80,  height: 60)
        public static let defaultSize   = CGSize(width: 200, height: 150)
        public static let maximumSize   = CGSize(width: 960, height: 640)
        /// Widgets snap to an 8-point grid on the desktop.
        public static let snapGrid: CGFloat = 8
        public static let padding:   CGFloat = 12
    }

    // MARK: - Animation

    public enum Animation {
        public static let defaultDuration: Double   = 0.3
        public static let fastDuration:    Double   = 0.15
        public static let slowDuration:    Double   = 0.6
        public static let springResponse:  Double   = 0.4
        public static let springDamping:   Double   = 0.82
    }

    // MARK: - Persistence Keys

    public enum Storage {
        public static let suiteName         = "com.desktopframe.preferences"
        public static let widgetLayoutKey   = "widgetLayout"
        public static let activeThemeKey    = "activeTheme"
        public static let wallpaperKey      = "wallpaperConfig"
        public static let launchAtLoginKey  = "launchAtLogin"
        public static let monitorMapKey     = "monitorMap"
    }

    // MARK: - Notification Names

    public enum Notifications {
        public static let desktopDidRefresh             = Notification.Name("DesktopFrame.desktopDidRefresh")
        public static let widgetDidUpdate               = Notification.Name("DesktopFrame.widgetDidUpdate")
        public static let widgetDidAdd                  = Notification.Name("DesktopFrame.widgetDidAdd")
        public static let widgetDidRemove               = Notification.Name("DesktopFrame.widgetDidRemove")
        public static let monitorConfigurationChanged   = Notification.Name("DesktopFrame.monitorConfigChanged")
        public static let themeDidChange                = Notification.Name("DesktopFrame.themeDidChange")
        public static let layoutDidChange               = Notification.Name("DesktopFrame.layoutDidChange")
        public static let wallpaperDidChange            = Notification.Name("DesktopFrame.wallpaperDidChange")
        public static let permissionsDidChange          = Notification.Name("DesktopFrame.permissionsDidChange")
    }

    // MARK: - Service Refresh Intervals (seconds)

    public enum RefreshInterval {
        public static let cpu:     TimeInterval = 1.0
        public static let memory:  TimeInterval = 2.0
        public static let network: TimeInterval = 2.0
        public static let battery: TimeInterval = 10.0
        public static let storage: TimeInterval = 30.0
        public static let calendar: TimeInterval = 60.0
    }
}
