// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "OmniRepo",
    platforms: [.macOS(.v14), .iOS(.v17)],
    products: [
        .library(name: "RepoCore", targets: ["RepoCore"]),
        .executable(name: "OmniRepo", targets: ["OmniRepo"]),
        .executable(name: "omnirepo-mcp", targets: ["OmniRepoMCP"])
    ],
    targets: [
        .target(name: "RepoCore"),
        .executableTarget(name: "OmniRepo", dependencies: ["RepoCore"]),
        .executableTarget(name: "OmniRepoMCP", dependencies: ["RepoCore"]),
        .testTarget(name: "RepoCoreTests", dependencies: ["RepoCore"])
    ]
)
