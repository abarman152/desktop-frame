import SwiftUI
import AppKit

public extension Color {

    // MARK: - Hex Initialiser

    /// Creates a `Color` from a 6-digit hex string, with or without a leading `#`.
    ///
    /// - Parameters:
    ///   - hex: e.g. `"#1A2B3C"` or `"1A2B3C"`
    ///   - opacity: Alpha value in the range `0…1`. Defaults to `1`.
    init(hex: String, opacity: Double = 1) {
        let cleaned = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let value   = UInt64(cleaned, radix: 16) ?? 0
        let r = Double((value >> 16) & 0xFF) / 255
        let g = Double((value >> 8)  & 0xFF) / 255
        let b = Double(value         & 0xFF) / 255
        self.init(.sRGB, red: r, green: g, blue: b, opacity: opacity)
    }

    // MARK: - Semantic Desktop Colours

    /// Adaptive glass-surface tint for widget backgrounds.
    static var widgetBackground: Color {
        Color(NSColor.windowBackgroundColor).opacity(0.6)
    }

    /// Subtle border drawn around interactive widget frames.
    static var widgetBorder: Color {
        Color(NSColor.separatorColor).opacity(0.4)
    }

    /// Primary text on desktop widgets, adapting to dark/light appearance.
    static var widgetPrimary: Color {
        Color(NSColor.labelColor)
    }

    /// Secondary annotation text on desktop widgets.
    static var widgetSecondary: Color {
        Color(NSColor.secondaryLabelColor)
    }

    // MARK: - NSColor Bridge

    /// The underlying `NSColor` representation.
    var nsColor: NSColor { NSColor(self) }

    // MARK: - Hex Export

    /// Returns the colour as an uppercase 6-digit hex string (e.g. `"1A2B3C"`).
    var hexString: String {
        let c = NSColor(self).usingColorSpace(.sRGB) ?? NSColor(self)
        let r = Int(c.redComponent   * 255)
        let g = Int(c.greenComponent * 255)
        let b = Int(c.blueComponent  * 255)
        return String(format: "%02X%02X%02X", r, g, b)
    }
}
