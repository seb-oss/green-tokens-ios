
import SwiftUI
import UIKit

public enum Typography {
   case headingXl
   case headingL
   case headingM
   case headingS
   case headingXs
   case heading2xs
   case detailBookM
   case detailBookS
   case detailBookXs
   case detailRegularM
   case detailRegularS
   case detailRegularXs
   case bodyBookL
   case bodyBookM
   case bodyBookS
   case bodyRegularL
   case bodyRegularM
   case bodyRegularS
   case bodyItalicL
   case bodyItalicM
   case bodyItalicS
   case display2xl
   case displayXl
   case displayL
   case displayM
   case displayS
   case preamble2xl
   case preambleXl
   case preambleL
   case preambleM
   case preambleS
   case preambleXs
   case detailBook2xs
   case detailRegular2xs
   case bodyMediumL
   case bodyMediumM
   case bodyMediumS
}

extension Typography {
    var size: CGFloat {
        switch self {
            case .headingXl: 34
            case .headingL: 28
            case .headingM: 24
            case .headingS: 20
            case .headingXs: 16
            case .heading2xs: 14
            case .detailBookM: 17
            case .detailBookS: 15
            case .detailBookXs: 12
            case .detailRegularM: 17
            case .detailRegularS: 15
            case .detailRegularXs: 12
            case .bodyBookL: 20
            case .bodyBookM: 17
            case .bodyBookS: 13
            case .bodyRegularL: 20
            case .bodyRegularM: 17
            case .bodyRegularS: 14
            case .bodyItalicL: 20
            case .bodyItalicM: 17
            case .bodyItalicS: 13
            case .display2xl: 82
            case .displayXl: 64
            case .displayL: 48
            case .displayM: 36
            case .displayS: 32
            case .preamble2xl: 32
            case .preambleXl: 28
            case .preambleL: 24
            case .preambleM: 20
            case .preambleS: 18
            case .preambleXs: 16
            case .detailBook2xs: 12
            case .detailRegular2xs: 11
            case .bodyMediumL: 20
            case .bodyMediumM: 17
            case .bodyMediumS: 13
        }
    }

    var textStyle: Font.TextStyle {
        switch self {
            case .headingXl: .largeTitle
            case .headingL: .title
            case .headingM: .title2
            case .headingS: .title3
            case .headingXs: .headline
            case .heading2xs: .headline
            case .detailBookM: .headline
            case .detailBookS: .subheadline
            case .detailBookXs: .caption
            case .detailRegularM: .headline
            case .detailRegularS: .subheadline
            case .detailRegularXs: .caption
            case .bodyBookL: .body
            case .bodyBookM: .body
            case .bodyBookS: .footnote
            case .bodyRegularL: .body
            case .bodyRegularM: .body
            case .bodyRegularS: .footnote
            case .bodyItalicL: .body
            case .bodyItalicM: .body
            case .bodyItalicS: .footnote
            case .display2xl: .footnote
            case .displayXl: .largeTitle
            case .displayL: .largeTitle
            case .displayM: .largeTitle
            case .displayS: .largeTitle
            case .preamble2xl: .title
            case .preambleXl: .title
            case .preambleL: .title2
            case .preambleM: .title3
            case .preambleS: .headline
            case .preambleXs: .subheadline
            case .detailBook2xs: .caption2
            case .detailRegular2xs: .caption2
            case .bodyMediumL: .body
            case .bodyMediumM: .body
            case .bodyMediumS: .footnote
        }
    }

  var weight: Typography.Weight {
    switch self {
       case .bodyMediumL, .bodyMediumM, .bodyMediumS:
            return .medium
       case .headingXl, .headingL, .headingM, .headingS, .headingXs, .heading2xs, .detailBookM, .detailBookS, .detailBookXs, .bodyBookL, .bodyBookM, .bodyBookS, .display2xl, .displayXl, .displayL, .displayM, .displayS, .preamble2xl, .preambleXl, .preambleL, .preambleM, .preambleS, .preambleXs, .detailBook2xs:
            return .book
       case .detailRegularM, .detailRegularS, .detailRegularXs, .bodyRegularL, .bodyRegularM, .bodyRegularS, .bodyItalicL, .bodyItalicM, .bodyItalicS, .detailRegular2xs:
            return .regular
    }
  }
}

extension Typography: CaseIterable {}
