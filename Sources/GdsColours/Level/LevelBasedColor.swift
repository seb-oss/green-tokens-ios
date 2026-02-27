import SwiftUI

public struct LevelBasedColor: ShapeStyle {
    let colorForLevel: @Sendable (Level) -> Color
    
    public init(_ colorForLevel: @Sendable @escaping (Level) -> Color) {
        self.colorForLevel = colorForLevel
    }
    
    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        colorForLevel(environment.level)
    }
}
