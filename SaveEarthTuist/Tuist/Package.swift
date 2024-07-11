// swift-tools-version: 5.9
@preconcurrency import PackageDescription
import ProjectDescriptionHelpers

#if TUIST
@preconcurrency import ProjectDescription

let packageSettings = PackageSettings(
  productTypes: [
    "ComposableArchitecture": .framework
  ],
  baseSettings: .settings(
    base: [:],
    configurations: Configuration
      .configure(
        configurations: Configuration.ConfigScheme.allCases
      )
  )
)
#endif

let package = Package(
  name: "SaveEarthTuist",
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", branch: "1.10.1")
  ]
)
