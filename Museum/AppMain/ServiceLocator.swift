//
//  ServiceLocator.swift
//  Museum
//
//  Created by Vyacheslav on 10.07.2023.
//

import Foundation

protocol ServiceLocating {
    associatedtype JsonServiceItem: JsonServiceProtocol
    func getJsonService() -> JsonServiceItem
    
    associatedtype UserProviderItem: UserProviderProtocol
    func getUserProvider() -> UserProviderItem
}

// all services in one place for the big picture, no shared ServiceLocator object for strong DI in ModuleBuilder
final class ServiceLocator: ServiceLocating {
    
    private lazy var services: [String: AnyObject] = [:]
    
    func getJsonService() -> some JsonServiceProtocol {
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
    
    func getUserProvider() -> some UserProviderProtocol {
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
    
}
