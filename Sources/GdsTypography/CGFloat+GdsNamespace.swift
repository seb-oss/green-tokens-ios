import Foundation
import GdsDimensions

public extension CGFloat {
    static func gds(_ token: GdsSpacing) -> CGFloat {
        return token.rawValue
    }
}

public extension CGFloat {
    static func gds(_ token: GdsRadius) -> CGFloat {
        return token.rawValue
    }
}
