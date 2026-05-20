
import SwiftUI
import UIKit

public struct Typography: Sendable {
    public let size: CGFloat
    public let textStyle: Font.TextStyle
    public let weight: Typography.Weight

    package init(size: CGFloat, textStyle: Font.TextStyle, weight: Typography.Weight) {
        self.size = size
        self.textStyle = textStyle
        self.weight = weight
    }
}

public extension Typography {
    static let displayL = Typography(size: 64, textStyle: .largeTitle, weight: .book)
    static let displayM = Typography(size: 48, textStyle: .largeTitle, weight: .book)
    static let displayS = Typography(size: 36, textStyle: .largeTitle, weight: .book)
    static let headingXl = Typography(size: 32, textStyle: .largeTitle, weight: .book)
    static let headingL = Typography(size: 28, textStyle: .title, weight: .book)
    static let headingM = Typography(size: 24, textStyle: .title2, weight: .book)
    static let headingS = Typography(size: 20, textStyle: .title3, weight: .book)
    static let headingXs = Typography(size: 16, textStyle: .headline, weight: .book)
    static let preambleXl = Typography(size: 28, textStyle: .title, weight: .book)
    static let preambleL = Typography(size: 24, textStyle: .title2, weight: .book)
    static let preambleM = Typography(size: 20, textStyle: .title3, weight: .book)
    static let preambleS = Typography(size: 18, textStyle: .headline, weight: .book)
    static let detailLRegular = Typography(size: 18, textStyle: .title3, weight: .regular)
    static let detailLBook = Typography(size: 18, textStyle: .title3, weight: .book)
    static let detailLMedium = Typography(size: 18, textStyle: .title3, weight: .medium)
    static let detailMRegular = Typography(size: 16, textStyle: .headline, weight: .regular)
    static let detailMBook = Typography(size: 16, textStyle: .headline, weight: .book)
    static let detailMMedium = Typography(size: 16, textStyle: .headline, weight: .medium)
    static let detailSRegular = Typography(size: 14, textStyle: .subheadline, weight: .regular)
    static let detailSBook = Typography(size: 14, textStyle: .subheadline, weight: .book)
    static let detailSMedium = Typography(size: 14, textStyle: .subheadline, weight: .medium)
    static let detailXsRegular = Typography(size: 12, textStyle: .caption, weight: .regular)
    static let detailXsBook = Typography(size: 12, textStyle: .caption, weight: .book)
    static let detailXsMedium = Typography(size: 12, textStyle: .caption, weight: .medium)
    static let detail2xsRegular = Typography(size: 10, textStyle: .caption2, weight: .regular)
    static let detail2xsBook = Typography(size: 10, textStyle: .caption2, weight: .book)
    static let detail2xsMedium = Typography(size: 10, textStyle: .caption2, weight: .medium)
    static let bodyLRegular = Typography(size: 18, textStyle: .body, weight: .regular)
    static let bodyLRegularItalic = Typography(size: 18, textStyle: .body, weight: .regular)
    static let bodyLBook = Typography(size: 18, textStyle: .body, weight: .book)
    static let bodyLMedium = Typography(size: 18, textStyle: .body, weight: .medium)
    static let bodyMRegular = Typography(size: 16, textStyle: .body, weight: .regular)
    static let bodyMRegularItalic = Typography(size: 16, textStyle: .body, weight: .regular)
    static let bodyMBook = Typography(size: 16, textStyle: .body, weight: .book)
    static let bodyMMedium = Typography(size: 16, textStyle: .body, weight: .medium)
    static let bodySRegular = Typography(size: 14, textStyle: .footnote, weight: .regular)
    static let bodySRegularItalic = Typography(size: 14, textStyle: .footnote, weight: .regular)
    static let bodySBook = Typography(size: 14, textStyle: .footnote, weight: .book)
    static let bodySMedium = Typography(size: 14, textStyle: .footnote, weight: .medium)
}
