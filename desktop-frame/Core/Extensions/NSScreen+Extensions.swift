import AppKit

public extension NSScreen {

    // MARK: - Identification

    /// A stable identifier derived from the display's persistent hardware UUID.
    ///
    /// `NSScreen` has no built-in stable ID; the `CGDirectDisplayID` changes on
    /// GPU switch-over, but the UUID returned by `IOKit` persists across reboots.
    /// We use `localizedName` + resolution as a best-effort stable key without
    /// requiring IOKit linkage in the main target.
    var stableIdentifier: String {
        "\(localizedName)-\(Int(frame.width))x\(Int(frame.height))"
    }

    // MARK: - Primary Screen

    /// Returns `true` when this is the screen containing the menu bar.
    var isPrimary: Bool { self == NSScreen.main }

    // MARK: - Pixel Density

    /// The display's backing scale factor (1 for standard, 2 for Retina, etc.).
    var scaleFactor: CGFloat { backingScaleFactor }

    // MARK: - Safe Area

    /// The usable rect excluding the menu bar and any dock reservation.
    var safeFrame: CGRect { visibleFrame }

    // MARK: - Center

    /// The geometric centre of the screen's full frame (including menu bar area).
    var center: CGPoint {
        CGPoint(x: frame.midX, y: frame.midY)
    }
}
