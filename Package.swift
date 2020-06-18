// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Emoji",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "Emoji",
            targets: ["Emoji"]
        ),
        .library(
            name: "EmojiImage",
            targets: ["EmojiImage"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Emoji",
            dependencies: [],
            path: "Sources/Emoji"
        ),
        .target(
            name: "EmojiImage",
            dependencies: ["Emoji"],
            path: "Sources/EmojiImage"
        ),
        .testTarget(
            name: "EmojiTests",
            dependencies: ["Emoji"]),
    ],
    swiftLanguageVersions: [.v5]
)
