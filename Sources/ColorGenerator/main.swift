import Foundation

// MARK: - Figma Variables Export Models

struct FigmaVariable: Codable {
    let name: String
    let id: String
    let description: String?
    let valuesByMode: [String: ModeValue]
    let resolvedType: String
}

enum ModeValue: Codable {
    case color(RGBAValue)
    case number(Double)
    case other

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        // Try to decode as RGBA color object
        if let rgba = try? container.decode(RGBAValue.self) {
            self = .color(rgba)
            return
        }

        // Try to decode as number
        if let num = try? container.decode(Double.self) {
            self = .number(num)
            return
        }

        // Fallback for other types
        self = .other
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .color(let rgba):
            try container.encode(rgba)
        case .number(let num):
            try container.encode(num)
        case .other:
            try container.encodeNil()
        }
    }
}

struct RGBAValue: Codable {
    let r: Double
    let g: Double
    let b: Double
    let a: Double
}

// MARK: - Color Conversion

struct RGBAColor {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double

    init(from figmaValue: RGBAValue) {
        self.red = figmaValue.r
        self.green = figmaValue.g
        self.blue = figmaValue.b
        self.alpha = figmaValue.a
    }
}

// MARK: - Name Transformation

func transformColorName(_ figmaName: String) -> String {
    // "L1/neutral-01" -> "l1Neutral01"
    let parts = figmaName.split(separator: "/")
    var result = ""

    for (index, part) in parts.enumerated() {
        let segments = part.split(separator: "-")
        for (segmentIndex, segment) in segments.enumerated() {
            let string = String(segment)
            if index == 0 && segmentIndex == 0 {
                result += string.lowercased()
            } else {
                result += string.prefix(1).uppercased() + string.dropFirst().lowercased()
            }
        }
    }

    return result
}

// MARK: - Asset Generation

struct ColorAssetGenerator {

    func generateColorSet(name: String, lightColor: RGBAColor, darkColor: RGBAColor?) -> String {
        var colorEntries: [String] = []

        // Dark mode color
        if let dark = darkColor {
            colorEntries.append(colorEntry(color: dark, appearance: "dark"))
        }

        // Light mode color
        colorEntries.append(colorEntry(color: lightColor, appearance: "light"))

        return """
        {
          "colors": [
            \(colorEntries.joined(separator: ",\n    "))
          ],
          "info": {
            "author": "xcode",
            "version": 1
          }
        }
        """
    }

    private func colorEntry(color: RGBAColor, appearance: String) -> String {
        """
        {
              "idiom": "universal",
              "appearances": [
                {
                  "appearance": "luminosity",
                  "value": "\(appearance)"
                }
              ],
              "color": {
                "color-space": "srgb",
                "components": {
                  "red": "\(String(format: "%.3f", color.red))",
                  "green": "\(String(format: "%.3f", color.green))",
                  "blue": "\(String(format: "%.3f", color.blue))",
                  "alpha": "\(String(format: "%.3f", color.alpha))"
                }
              }
            }
        """
    }

    func generateContentsJson() -> String {
        """
        {
          "info": {
            "author": "xcode",
            "version": 1
          }
        }
        """
    }
}

// MARK: - Swift Code Generation

struct SwiftCodeGenerator {

    func generate(colorNames: [String]) -> String {
        let header = """

        /**
         * Do not edit directly, this file was auto-generated.
         */



        import UIKit
        import SwiftUI
        
        """

        let uiColorExtension = generateUIColorExtension(colorNames: colorNames)
        let colorExtension = generateColorExtension(colorNames: colorNames)

        return header + "\n" + uiColorExtension + "\n\n" + colorExtension
    }

    private func generateUIColorExtension(colorNames: [String]) -> String {
        var lines = ["public extension UIColor {"]

        for name in colorNames {
            lines.append("""
                static var \(name): UIColor { gdsColor(named: "\(name)") }
            """)
        }

        lines.append("")
        lines.append("""
            private static func gdsColor(named name: String) -> UIColor {
                guard let color = UIColor(named: name, in: .module, compatibleWith: nil) else {
                    assertionFailure("Missing color asset 'name' in GdsColours resources")
                    return .clear
                }
                return color
            }
        }
        """)

        return lines.joined(separator: "\n")
    }

    private func generateColorExtension(colorNames: [String]) -> String {
        var lines = ["public extension Color {"]

        for name in colorNames {
            lines.append("""
                static var \(name): Color { gdsColor("\(name)") }
            """)
        }

        lines.append("")
        lines.append("""
            private static func gdsColor(_ name: String) -> Color {
                Color(name, bundle: .module)
            }
        }
        """)

        return lines.joined(separator: "\n")
    }
}

// MARK: - CLI

struct CLI {

    func run() throws {
        let arguments = CommandLine.arguments

        if arguments.contains("--help") || arguments.contains("-h") {
            printHelp()
            return
        }

        guard let inputIndex = arguments.firstIndex(of: "--input"),
              inputIndex + 1 < arguments.count else {
            print("Error: --input <path> is required")
            printHelp()
            exit(1)
        }

        guard let outputIndex = arguments.firstIndex(of: "--output"),
              outputIndex + 1 < arguments.count else {
            print("Error: --output <path> is required")
            printHelp()
            exit(1)
        }

        let inputPath = arguments[inputIndex + 1]
        let outputPath = arguments[outputIndex + 1]

        // Parse optional mode mapping
        var lightModeKey = "1:0"
        var darkModeKey = "1:1"

        if let lightIndex = arguments.firstIndex(of: "--light-mode"),
           lightIndex + 1 < arguments.count {
            lightModeKey = arguments[lightIndex + 1]
        }

        if let darkIndex = arguments.firstIndex(of: "--dark-mode"),
           darkIndex + 1 < arguments.count {
            darkModeKey = arguments[darkIndex + 1]
        }

        try generateColors(inputPath: inputPath, outputPath: outputPath, lightModeKey: lightModeKey, darkModeKey: darkModeKey)
    }

    private func printHelp() {
        print("""
        ColorGenerator - Generate Xcode color assets from Figma Variables export

        USAGE:
            swift run ColorGenerator --input <figma-export.json> --output <directory>

        OPTIONS:
            --input       Path to Figma Variables JSON export file
            --output      Output directory (e.g., Sources/GdsColours)
            --light-mode  Mode key for light mode (default: "1:0")
            --dark-mode   Mode key for dark mode (default: "1:1")
            --help, -h    Show this help message

        OUTPUT:
            <output>/GdsColours.swift
            <output>/Resources/Colours.xcassets/

        FIGMA EXPORT FORMAT:
            [
              {
                "name": "L1/neutral-01",
                "valuesByMode": {
                  "1:0": { "r": 1, "g": 1, "b": 1, "a": 1 },
                  "1:1": { "r": 0.039, "g": 0.043, "b": 0.043, "a": 1 }
                },
                "resolvedType": "COLOR"
              }
            ]
        """)
    }

    private func generateColors(inputPath: String, outputPath: String, lightModeKey: String, darkModeKey: String) throws {
        let fileManager = FileManager.default

        // Read input file
        let inputURL = URL(fileURLWithPath: inputPath)
        let data = try Data(contentsOf: inputURL)
        let figmaVariables = try JSONDecoder().decode([FigmaVariable].self, from: data)

        // Filter to only COLOR types
        let colors = figmaVariables.filter { $0.resolvedType == "COLOR" }

        guard !colors.isEmpty else {
            print("No colors found in Figma export file")
            return
        }

        // Create output directories
        let resourcesPath = (outputPath as NSString).appendingPathComponent("Resources")
        let xcassetsPath = (resourcesPath as NSString).appendingPathComponent("Colours.xcassets")
        try fileManager.createDirectory(atPath: xcassetsPath, withIntermediateDirectories: true)

        let assetGenerator = ColorAssetGenerator()
        let swiftGenerator = SwiftCodeGenerator()

        // Write xcassets Contents.json
        let xcassetsContentsPath = (xcassetsPath as NSString).appendingPathComponent("Contents.json")
        try assetGenerator.generateContentsJson().write(toFile: xcassetsContentsPath, atomically: true, encoding: .utf8)

        var colorNames: [String] = []

        // Generate color sets
        for figmaColor in colors {
            let name = transformColorName(figmaColor.name)

            guard let lightModeValue = figmaColor.valuesByMode[lightModeKey],
                  case .color(let lightValue) = lightModeValue else {
                print("Warning: No light mode color for '\(figmaColor.name)' (key: \(lightModeKey))")
                continue
            }

            let lightColor = RGBAColor(from: lightValue)
            let darkColor: RGBAColor?

            if let darkModeValue = figmaColor.valuesByMode[darkModeKey],
               case .color(let darkValue) = darkModeValue {
                darkColor = RGBAColor(from: darkValue)
            } else {
                darkColor = nil
            }

            let colorSetPath = (xcassetsPath as NSString).appendingPathComponent("\(name).colorset")
            try fileManager.createDirectory(atPath: colorSetPath, withIntermediateDirectories: true)

            let contentsJson = assetGenerator.generateColorSet(name: name, lightColor: lightColor, darkColor: darkColor)
            let contentsPath = (colorSetPath as NSString).appendingPathComponent("Contents.json")
            try contentsJson.write(toFile: contentsPath, atomically: true, encoding: .utf8)

            colorNames.append(name)
        }

        // Sort color names for consistent output
        colorNames.sort()

        // Generate Swift code
        let swiftCode = swiftGenerator.generate(colorNames: colorNames)
        let swiftPath = (outputPath as NSString).appendingPathComponent("GdsColours.swift")
        try swiftCode.write(toFile: swiftPath, atomically: true, encoding: .utf8)

        print("Generated \(colorNames.count) color assets")
        print("Output: \(outputPath)")
    }
}

// MARK: - Main

do {
    try CLI().run()
} catch {
    print("Error: \(error)")
    exit(1)
}
