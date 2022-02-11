// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "EmailValidation",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "EmailValidation", targets: ["EmailValidation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.9.0")
    ],
    targets: [
        .target(name: "EmailValidation", dependencies: [
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
        ]),
        .testTarget(name: "EmailValidationTests", dependencies: [
            .target(name: "EmailValidation")
        ]),
    ]
)
