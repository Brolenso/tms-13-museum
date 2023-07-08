// singletone
final class User: Codable {
    
    private(set) var email: String
    private(set) var password: String
    
    public static let current: User = User()
    
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

extension User: JsonFileStorableProtocol {
    
    static var jsonFileName: String = "userInfo.json"
    
}
