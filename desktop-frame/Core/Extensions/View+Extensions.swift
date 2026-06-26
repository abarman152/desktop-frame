import SwiftUI

public extension View {

    // MARK: - Conditional Modifier

    /// Applies a transform to `self` only when `condition` is `true`.
    ///
    /// Prefer this over ternary expressions that require the same modifier twice.
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition { transform(self) } else { self }
    }

    /// Applies one of two transforms depending on `condition`.
    @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>(
        _ condition: Bool,
        then trueTransform: (Self) -> TrueContent,
        else falseTransform: (Self) -> FalseContent
    ) -> some View {
        if condition { trueTransform(self) } else { falseTransform(self) }
    }

    // MARK: - Glass Effect

    /// Applies the standard Desktop Frame glass card appearance.
    func glassCard(
        cornerRadius: CGFloat = AppConstants.Window.defaultCornerRadius,
        padding:      CGFloat = AppConstants.Widget.padding
    ) -> some View {
        self
            .padding(padding)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(Color.widgetBorder, lineWidth: 0.5)
            )
    }

    // MARK: - Widget Shadow

    /// Subtle drop shadow appropriate for desktop widgets.
    func widgetShadow() -> some View {
        shadow(color: .black.opacity(0.18), radius: 12, x: 0, y: 4)
    }

    // MARK: - Accessibility

    /// Marks a purely decorative element so assistive technologies skip it.
    func decorative() -> some View {
        accessibilityHidden(true)
    }

    // MARK: - Geometry Capture

    /// Reads the view's size and writes it to `binding`.
    func readSize(into binding: Binding<CGSize>) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: proxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self) { binding.wrappedValue = $0 }
    }
}

// MARK: - Size Preference Key

private struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
