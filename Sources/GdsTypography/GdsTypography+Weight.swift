import UIKit

extension Typography {
    public enum Weight: CaseIterable, Sendable {
        case bold
        case boldItalic
        case book
        case bookItalic
        case italic
        case light
        case lightItalic
        case medium
        case mediumItalic
        case regular

        var fontName: String {
            switch self {
            case .bold: "SEBSansSerif-Bold"
            case .boldItalic: "SEBSansSerif-BoldItalic"
            case .book: "SEBSansSerif-Book"
            case .bookItalic: "SEBSansSerif-BookItalic"
            case .italic: "SEBSansSerif-Italic"
            case .light: "SEBSansSerif-Light"
            case .lightItalic: "SEBSansSerif-LightItalic"
            case .medium: "SEBSansSerif-Medium"
            case .mediumItalic: "SEBSansSerif-MediumItalic"
            case .regular: "SEBSansSerif"
            }
        }
    }
}