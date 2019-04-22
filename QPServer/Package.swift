// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QPServer",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0"),
         .package(url:"https://github.com/PerfectlySoft/Perfect-WebSockets.git", from: "3.0.0"),
         .package(url:"https://github.com/PerfectlySoft/Perfect-MongoDB", from: "3.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "QPServer",
            dependencies: ["PerfectHTTPServer", "PerfectWebSockets", "PerfectMongoDB"]),
        .testTarget(
            name: "QPServerTests",
            dependencies: ["QPServer"]),
    ]
)
