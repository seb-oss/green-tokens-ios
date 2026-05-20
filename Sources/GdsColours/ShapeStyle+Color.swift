import SwiftUI

public extension ShapeStyle where Self == Color {
    static func gds(_ gdsColor: GdsColor) -> Self {
        Color(gdsColor.rawValue, bundle: .module)
    }
}