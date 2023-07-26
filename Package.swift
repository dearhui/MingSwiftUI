// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MingSwiftUI",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "MingSwiftUI",
            targets: ["MingSwiftUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/siteline/SwiftUI-Introspect.git", exact: "0.1.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MingSwiftUI", dependencies: [.product(name: "Introspect", package: "SwiftUI-Introspect")]),
        .testTarget(
            name: "MingSwiftUITests",
            dependencies: ["MingSwiftUI", .product(name: "Introspect", package: "SwiftUI-Introspect")]),
    ]
)
