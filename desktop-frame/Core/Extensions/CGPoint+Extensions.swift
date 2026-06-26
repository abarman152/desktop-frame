import CoreGraphics

extension CGPoint: @retroactive Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

public extension CGPoint {

    // MARK: - Arithmetic

    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    // MARK: - Geometry

    /// Euclidean distance to another point.
    func distance(to other: CGPoint) -> CGFloat {
        let dx = x - other.x
        let dy = y - other.y
        return (dx * dx + dy * dy).squareRoot()
    }

    /// Returns the point snapped to the nearest grid intersection.
    func snapped(to grid: CGFloat = AppConstants.Widget.snapGrid) -> CGPoint {
        CGPoint(
            x: (x / grid).rounded() * grid,
            y: (y / grid).rounded() * grid
        )
    }

    // MARK: - Coordinate Space Conversion

    /// Converts from AppKit's bottom-left origin to SwiftUI's top-left origin
    /// for the given screen height.
    func toSwiftUICoordinates(screenHeight: CGFloat) -> CGPoint {
        CGPoint(x: x, y: screenHeight - y)
    }

    /// Converts from SwiftUI's top-left origin back to AppKit's bottom-left origin.
    func toAppKitCoordinates(screenHeight: CGFloat) -> CGPoint {
        toSwiftUICoordinates(screenHeight: screenHeight)
    }

    // MARK: - Clamping

    /// Clamps the point so it lies within `rect`.
    func clamped(to rect: CGRect) -> CGPoint {
        CGPoint(
            x: Swift.max(rect.minX, Swift.min(rect.maxX, x)),
            y: Swift.max(rect.minY, Swift.min(rect.maxY, y))
        )
    }
}
