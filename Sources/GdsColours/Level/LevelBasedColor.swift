import SwiftUI

public struct LevelBasedColor: ShapeStyle {
    let colorForLevel: @Sendable (Level, UIUserInterfaceLevel) -> Color
    
    public init(_ colorForLevel: @Sendable @escaping (Level, UIUserInterfaceLevel) -> Color) {
        self.colorForLevel = colorForLevel
    }
    
    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        colorForLevel(environment.level, environment.userInterfaceLevel)
    }
}
