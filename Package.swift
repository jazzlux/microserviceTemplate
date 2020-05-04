// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "template",
    products: [
        .library(name: "template", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        
        // MySQL Fluent package
       .package(url: "https://github.com/vapor/fluent.git", from: "3.0.0"),
       .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "3.0.0"),
       .package(url: "https://github.com/skelpo/JWTMiddleware.git", from: "0.6.1")
  
 

    ],
    targets: [
        .target(name: "App", dependencies: ["FluentMySQL","FluentSQLite", "Vapor", "JWTMiddleware"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

