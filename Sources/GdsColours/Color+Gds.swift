import SwiftUI

public extension Color {
    static func gds(_ color: GdsColor) -> Color {
        Color(color.rawValue, bundle: .module)
    }
    
    static func gds(_ color: GdsColor, bundle: Bundle) -> Color {
        Color(color.rawValue, bundle: bundle)
    }
}