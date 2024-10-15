// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.
//

// Do not edit directly
// Generated on Tue, 15 Oct 2024 15:15:52 GMT


import PackageDescription

let package = Package(
    name: "GreenTokens",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "GreenTokens",
            targets: ["GreenTokens"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GreenTokens",
            dependencies: [],
            resources: [
                .process("Assets")
            ]
        )
    ]
)
