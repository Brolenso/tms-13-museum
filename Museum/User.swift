class User: Codable {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    public func erase() {
        email = ""
        password = ""
    }
}
