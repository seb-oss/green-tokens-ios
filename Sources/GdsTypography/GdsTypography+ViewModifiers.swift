import SwiftUI

// MARK: - Modifier function

public extension View {
    /// Apply SEB font + the correct Apple leading for a given text style.
    @available(*, deprecated, message: "Use Typography2 with .font(.gds(_:)) instead.")
    func typography(_ style: Typography) -> some View {
        modifier(style)
    }
}

// MARK: - ViewModifier that enforces leading (line height)

extension Typography: ViewModifier {
    public func body(content: Content) -> some View {
        content.font(
            .custom(weight.fontName, size: size, relativeTo: textStyle)
        )
    }
}

public extension Font {
    /// Returns a GDS font matching the given typography style.
    static func gds(_ typography: Typography) -> Font {
        if !Typography.isRegistered {
            Typography.registerFonts()
        }

        return .custom(typography.weight.fontName, size: typography.size, relativeTo: typography.textStyle)
    }
}
