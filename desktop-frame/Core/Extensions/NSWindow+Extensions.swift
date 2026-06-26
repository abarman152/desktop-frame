import AppKit

public extension NSWindow {

    // MARK: - Desktop Layer Configuration

    /// Configures the window to sit on the desktop layer, below Finder icons.
    ///
    /// After calling this the window:
    /// - Is transparent and non-opaque.
    /// - Cannot become key or main (will not steal focus).
    /// - Appears on every Space and is excluded from Mission Control.
    /// - Has no shadow.
    func configureAsDesktopLayer() {
        level               = NSWindow.Level(rawValue: Int(AppConstants.Window.desktopLevel))
        backgroundColor     = .clear
        isOpaque            = false
        hasShadow           = false
        // Stationary keeps the window pinned when other apps activate.
        collectionBehavior  = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        isReleasedWhenClosed = false
    }

    // MARK: - Overlay Layer Configuration

    /// Configures the window as a floating overlay above all normal windows.
    func configureAsOverlay() {
        level               = NSWindow.Level(rawValue: Int(AppConstants.Window.overlayLevel))
        backgroundColor     = .clear
        isOpaque            = false
        hasShadow           = false
        collectionBehavior  = [.canJoinAllSpaces, .fullScreenAuxiliary]
        isReleasedWhenClosed = false
    }

    // MARK: - Geometry Helpers

    /// Centres the window on its current screen.
    func centerOnScreen() {
        guard let screen else { return }
        let x = screen.visibleFrame.midX - frame.width  / 2
        let y = screen.visibleFrame.midY - frame.height / 2
        setFrameOrigin(NSPoint(x: x, y: y))
    }

    /// Fills the entire visible area of the given screen.
    func fillScreen(_ screen: NSScreen) {
        setFrame(screen.frame, display: true, animate: false)
    }

    // MARK: - Hosting

    /// Embeds a SwiftUI view tree as the window's content using `NSHostingView`.
    func setSwiftUIContent<Content: View>(_ content: Content) {
        let hosting = NSHostingView(rootView: content)
        hosting.autoresizingMask = [.width, .height]
        contentView = hosting
    }
}
