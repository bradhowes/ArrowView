// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ArrowView",
  platforms: [.iOS(.v12)],
  products: [.library(name: "ArrowView", targets: ["ArrowView"])],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.9.0"),
  ],
  targets: [
    .target(name: "ArrowView", dependencies: []),
    .testTarget(name: "ArrowViewTests", dependencies: ["ArrowView", "SnapshotTesting"], exclude: ["__Snapshots__/"])
  ]
)
