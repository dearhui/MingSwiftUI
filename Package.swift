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
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI", from: "2.0.0"),
        .package(url: "https://github.com/CodeSlicing/pure-swift-ui", from: "3.0.0"),
        .package(url: "https://github.com/yeahdongcn/RSBarcodes_Swift", from: "5.1.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MingSwiftUI",
            dependencies: ["SDWebImageSwiftUI", .product(name: "PureSwiftUI", package: "pure-swift-ui"), "RSBarcodes_Swift"]),
        .testTarget(
            name: "MingSwiftUITests",
            dependencies: ["MingSwiftUI", "SDWebImageSwiftUI", .product(name: "PureSwiftUI", package: "pure-swift-ui"), "RSBarcodes_Swift"]),
    ]
)
