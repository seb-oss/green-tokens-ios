import UIKit

public extension UIColor {
    static func gds(_ color: GdsColor) -> UIColor {
        guard let validatedColor = UIColor(named: color.rawValue, in: .module, compatibleWith: nil) else {
            assertionFailure("Missing color asset '\\(color.rawValue)' in GdsColours resources")
            return .clear
        }
        
        return validatedColor
    }
    
    static func gds(_ color: GdsColor, bundle: Bundle) -> UIColor {
        guard let validatedColor = UIColor(named: color.rawValue, in: bundle, compatibleWith: nil) else {
            assertionFailure("Missing color asset '\\(color.rawValue)' in GdsColours resources")
            return .clear
        }
        
        return validatedColor
    }
}