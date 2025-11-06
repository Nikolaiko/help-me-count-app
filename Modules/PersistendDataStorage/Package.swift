// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PersistendDataStorage",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "PersistendDataStorage",
            targets: ["PersistendDataStorage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/sqlite-data", from: "1.0.0"),
        .package(path: "../CommonModels")
    ],
    targets: [
        .target(
            name: "PersistendDataStorage",
            dependencies: [
                .product(name: "SQLiteData", package: "sqlite-data"),
                .product(name: "CommonModels", package: "CommonModels")
            ]
        ),
        .testTarget(
            name: "PersistendDataStorageTests",
            dependencies: ["PersistendDataStorage"]
        ),
    ]
)
