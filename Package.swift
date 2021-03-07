// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "EmailValidation",
    products: [
        .library(
            name: "EmailValidation",
            targets: ["EmailValidation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "EmailValidation",
            dependencies: [
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
            ]),
        .testTarget(
            name: "EmailValidationTests",
            dependencies: ["EmailValidation"]),
    ]
)
