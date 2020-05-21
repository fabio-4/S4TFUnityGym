// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "S4TFUnityGym",
    platforms: [
        .macOS(.v10_13),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "S4TFUnityGym",
            targets: ["S4TFUnityGym"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "SwiftProtobuf", url: "https://github.com/apple/swift-protobuf.git", from: "1.4.0"),
        .package(name: "Socket", url: "https://github.com/IBM-Swift/BlueSocket.git", from: "1.0.45")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "S4TFUnityGym",
            dependencies: ["SwiftProtobuf", "Socket"]),
        .testTarget(
            name: "S4TFUnityGymTests",
            dependencies: ["S4TFUnityGym"]),
    ]
)
