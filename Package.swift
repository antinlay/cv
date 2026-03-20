// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "cv",
    platforms: [.macOS(.v14)],
    products: [
        .executable(name: "cv", targets: ["cv"])
    ],
    dependencies: [
        .package(url: "https://github.com/twostraws/Ignite.git", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "cv",
            dependencies: ["Ignite"]
        )
    ]
)
