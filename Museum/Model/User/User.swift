//
//  User.swift
//  Museum
//
//  Created by Vyacheslav on 08.07.2023.
//

class User: Codable {
    
    // MARK: Public Properties
    
    var email: String
    var password: String
    
    
    // MARK: Public Methods

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
}


// MARK: - JsonFileStorable

extension User: JsonFileStorable {
    
    static var jsonFileName: String = "userInfo.json"
    
}
