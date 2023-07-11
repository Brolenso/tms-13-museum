//
//  ServiceLocator.swift
//  Museum
//
//  Created by Vyacheslav on 10.07.2023.
//

import Foundation

protocol ServiceLocating {
    func getJsonService() -> JsonServiceProtocol
    func getUserProvider() -> UserProviding
    func getEventProvider() -> EventProviding
}

// all services in one place for the big picture, no shared ServiceLocator object for strong DI in ModuleBuilder
final class ServiceLocator: ServiceLocating {
    
    private lazy var services: [String: AnyObject] = [:]
    
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
    
    func getUserProvider() -> UserProviding {
        let key = "UserProvider"
        // exist
        if let service = services[key] as? UserProvider {
            return service
        }
        // not exist
        let jsonService = getJsonService()
        let service = UserProvider(jsonService: jsonService)
        services[key] = service
        return service
    }
    
    func getEventProvider() -> EventProviding {
        let key = "EventProvider"
        // service exist
        if let service = services[key] as? EventProvider {
            return service
        }
        // service not exist
        let service = EventProvider()
        services[key] = service
        return service
    }
    
}
