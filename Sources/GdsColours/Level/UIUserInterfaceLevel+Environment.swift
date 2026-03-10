import SwiftUI

struct UserInferfaceLevel: EnvironmentKey {
    static var defaultValue: UIUserInterfaceLevel {
        UITraitCollection.current.userInterfaceLevel
    }
}

extension EnvironmentValues {
    var userInterfaceLevel: UIUserInterfaceLevel {
        get { self[UserInferfaceLevel.self] }
    }
}

public extension UIUserInterfaceLevel {
    var isElevated: Bool {
        self == .elevated
    }
}
