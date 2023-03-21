// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "FloorPlan",
                      platforms: [.iOS(.v11)],
                      products: [.library(name: "FloorPlan", targets: ["FloorPlan"])],
                      dependencies: [],
                      targets: [.target(name: "FloorPlan", dependencies: []),
                                .testTarget(name: "FloorPlanTests", dependencies: ["FloorPlan"])],
                      swiftLanguageVersions: [.v5])
