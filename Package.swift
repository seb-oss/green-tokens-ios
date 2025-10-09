// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
/**
 * Do not edit directly, this file was auto-generated.
 */


import PackageDescription

let package = Package(
    name: "GdsKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "GdsKit",
            targets: [
                "GdsKit",
                "GdsColours",
                "GdsTypography"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GdsKit",
            dependencies: [
                "GdsColours",
                "GdsTypography",
                "GdsDimension"
            ]
        ),
        .target(
            name: "GdsColours",
            dependencies: [],
            path: "Sources/GdsColours",
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "GdsTypography",
            dependencies: [],
            path: "Sources/GdsTypography",
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "GdsDimension",
            dependencies: [],
            path: "Sources/GdsDimension"
        )
    ]
)
