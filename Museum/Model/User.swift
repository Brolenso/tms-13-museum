class User: Codable {
    var email: String
    var password: String
    
    static let current: User = User()
    
    private init(email: String = "", password: String = "") {
        self.email = email
        self.password = password
    }
    
    public func erase() {
        email = ""
        password = ""
    }
    
    public func setUser(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
