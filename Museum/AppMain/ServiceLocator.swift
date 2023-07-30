//
//  ServiceLocator.swift
//  Museum
//
//  Created by Vyacheslav on 10.07.2023.
//

import Foundation

protocol ServiceLocating {
    func getJsonService() -> JsonServiceProtocol
    func getUserProvider() -> UserRepositoryProtocol
    func getEventProvider() -> EventRepositoryProtocol
}

// all services in one place for the big picture, no shared ServiceLocator object for strong DI in ModuleBuilder
final class ServiceLocator: ServiceLocating {
    
    // MARK: Private Properties
    
    private lazy var services: [String: AnyObject] = [:]
    
    
    // MARK: Public Methods
    
    func getJsonService() -> JsonServiceProtocol {
        let key = "JsonService"
        // service exist
        if let service = services[key] as? JsonService {
            return service
        }
        // service not exist
        let service = JsonService()
        services[key] = service
        return service
    }
    
    func getUserProvider() -> UserRepositoryProtocol {
        let key = "UserRepository"
        // exist
        if let service = services[key] as? UserRepositoryProtocol {
            return service
        }
        // not exist
        let jsonService = getJsonService()
        let service = UserRepository(jsonService: jsonService)
        services[key] = service
        return service
    }
    
    func getEventProvider() -> EventRepositoryProtocol {
        let key = "EventRepository"
        // service exist
        if let service = services[key] as? EventRepositoryProtocol {
            return service
        }
        // service not exist
        let service = EventRepository()
        services[key] = service
        return service
    }
    
}
