//
//  ServiceLocator.swift
//  Museum
//
//  Created by Vyacheslav on 10.07.2023.
//

import Foundation

protocol ServiceLocating {
    func addService<T>(_ service: T)
    func getService<T>() -> T?
}

final class ServiceLocator: ServiceLocating {
    
    private lazy var services: [String: Any] = [:]
    
    func addService<T>(_ service: T) {
        let key = String(describing: T.self)
        services[key] = service
    }
    
    func getService<T>() -> T? {
        let key = String(describing: T.self)
        return services[key] as? T
    }
    
}
