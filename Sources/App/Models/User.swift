import FluentMySQL
import Vapor

final class User: MySQLModel {
    var id: Int?
    
    var name: String
    
    var age: Int
    
    init(id: Int, name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }

    
    
}

extension User: Content {}
extension User: Migration{}

