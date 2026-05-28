import UIKit
import os.log

extension Typography {
    private enum Error: LocalizedError {
        case fontRegistrationFailed(name: String)
        
        var errorDescription: String? {
            switch self {
            case .fontRegistrationFailed(let name):
                "Failed to register font \(name)"
            }
        }
    }

    static var isRegistered: Bool = false

    public static func registerFonts() {
        if isRegistered {
            return
        }
        do {
            for weight in Weight.allCases {
                try Typography.registerFont(named: weight.fontName)
            }
            isRegistered = true
            logger.debug("Registered all GDS fonts successfully.")
        } catch {
            logger.error("\(error.localizedDescription)")
        }
    }

    private static func registerFont(named name: String) throws(Error) {
        guard
            let asset = NSDataAsset(name: "\(name)", bundle: Bundle.module),
            let provider = CGDataProvider(data: asset.data as NSData),
            let font = CGFont(provider),
            CTFontManagerRegisterGraphicsFont(font, nil)
        else {
            logger.error("Failed to register font \(name)")
            throw .fontRegistrationFailed(name: name)
        }
    }
}

private let logger = Logger(subsystem: "se.seb.gdskit", category: "Typography")

#if DEBUG
import SwiftUI

/// Registers SebGreen fonts exactly once for SwiftUI previews.
private enum _PreviewFontRegistrar {
    static var didRegister = false
    static func registerIfNeeded() {
        guard !didRegister else { return }
        Typography.registerFonts()
        didRegister = true
    }
}

public extension View {
    /// Call this in your `#Preview` or `PreviewProvider` to ensure package fonts are available.
    ///
    /// Example:
    /// ```swift
    /// #Preview {
    ///     MyComponent()
    ///         .sebRegisterFontsForPreview()
    /// }
    /// ```
    func previewByRegisteringFonts() -> some View {
        _PreviewFontRegistrar.registerIfNeeded()
        return self
    }
}
#endif
