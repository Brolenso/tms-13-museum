//
//  UserRepository.swift
//  Museum
//
//  Created by Vyacheslav on 10.07.2023.
//

import Foundation

protocol UserRepositoryProtocol {
    init(jsonService: JsonServiceProtocol)
    func setUser(user: User)
    func getUser() -> User?
    func deleteUser()
}

class UserRepository: UserRepositoryProtocol {
    
    // MARK: Private Properties
    
    private let jsonService: JsonServiceProtocol
    
    
    // MARK: Initialisers
    
    required init(jsonService: JsonServiceProtocol) {
        self.jsonService = jsonService
    }
    
    
    // MARK: Public Methods
    
    func setUser(user: User) {
        jsonService.write(dataObject: user)
    }
    
    func getUser() -> User? {
        jsonService.read(type: User.self)
    }
    
    func deleteUser() {
        jsonService.delete(type: User.self)
    }
    
}
