import SwiftUI

public extension Font {
    static func seb(_ typography: Typography) -> Font {
        .custom(typography.weight.fontName, size: typography.size, relativeTo: typography.textStyle)
    }
}
