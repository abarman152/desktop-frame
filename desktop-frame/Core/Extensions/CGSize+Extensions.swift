import CoreGraphics

extension CGSize: @retroactive Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(width)
        hasher.combine(height)
    }
}

public extension CGSize {

    // MARK: - Common Sizes

    static let unit = CGSize(width: 1, height: 1)

    // MARK: - Arithmetic

    /// Returns a new size with `delta` added to both dimensions.
    func inset(by delta: CGFloat) -> CGSize {
        CGSize(width: max(0, width - delta * 2), height: max(0, height - delta * 2))
    }

    /// Scales both dimensions by `factor`.
    func scaled(by factor: CGFloat) -> CGSize {
        CGSize(width: width * factor, height: height * factor)
    }

    // MARK: - Aspect Ratio

    /// The width-to-height ratio.
    var aspectRatio: CGFloat {
        guard height != 0 else { return 1 }
        return width / height
    }

    /// Returns a size that fits `self` within `container` while preserving aspect ratio.
    func fitting(in container: CGSize) -> CGSize {
        let scale = min(container.width / width, container.height / height)
        return scaled(by: scale)
    }

    // MARK: - Clamping

    /// Clamps both dimensions to the given minimum and maximum sizes.
    func clamped(min minSize: CGSize, max maxSize: CGSize) -> CGSize {
        CGSize(
            width:  Swift.max(minSize.width,  Swift.min(maxSize.width,  width)),
            height: Swift.max(minSize.height, Swift.min(maxSize.height, height))
        )
    }

    /// Clamps to Desktop Frame's widget size constraints.
    var clampedToWidgetBounds: CGSize {
        clamped(min: AppConstants.Widget.minimumSize, max: AppConstants.Widget.maximumSize)
    }

    // MARK: - Snapping

    /// Snaps both dimensions to the nearest multiple of `grid`.
    func snapped(to grid: CGFloat = AppConstants.Widget.snapGrid) -> CGSize {
        CGSize(
            width:  (width  / grid).rounded() * grid,
            height: (height / grid).rounded() * grid
        )
    }
}
