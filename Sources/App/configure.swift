import Fluent
import FluentMySQL
import FluentSQLite
import Vapor
import JWT

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentSQLiteProvider())
    try services.register(FluentMySQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response

    middlewares.use(CORSMiddleware())
    services.register(middlewares)

    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .memory)

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)

    
    guard let jwksString = Environment.get("JWKS")
        else { fatalError("No value was found at the given public key environment 'JWKS'")
     }
     
    guard let mysqlUrl = Environment.get("MYSQL_CRED")
        else { fatalError("No value was found at the given public key environment 'MYSQL_CRED'")
            }
    
     guard let url = URL(string: mysqlUrl)
        
        else { fatalError("Cannot parse: \(mysqlUrl) correctly.")
     }
    
//    try jwt.signers.use(jwksJSON: jwksString)
    
//     app.databases.use(try .mysql(url: url), as: .mysql)
     
     
    
    
    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Todo.self, database: .sqlite)
//    migrations.add(model: User.self, database: .mysql)
    services.register(migrations)
}
