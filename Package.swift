// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ArrowView",
    products: [.library(name: "ArrowView", targets: ["ArrowView"])],
    dependencies: [],
    targets: [.target(name: "ArrowView", dependencies: []), .testTarget(name: "ArrowViewTests", dependencies: ["ArrowView"])]
)
