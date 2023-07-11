class User: Codable {
    
    var email: String
    var password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
}

extension User: JsonFileStorable {
    
    static var jsonFileName: String = "userInfo.json"
    
}
