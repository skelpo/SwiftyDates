// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SwiftyDates",
    products: [
        .library(name: "SwiftyDates", targets: ["SwiftyDates"]),
    ],
    targets: [
        .target(name: "SwiftyDates", dependencies: [], path: "Sources"),
        .testTarget(
            name: "SwiftyDatesTests",
            dependencies: ["SwiftyDates"],
            path: "SwiftyDatesTests"
        ),
    ]
)
