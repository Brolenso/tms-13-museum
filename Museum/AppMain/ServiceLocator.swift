//
//  ServiceLocator.swift
//  Museum
//
//  Created by Vyacheslav on 10.07.2023.
//

import Foundation

protocol ServiceLocating {
    func addService<T>(_ serviceObject: T)
    func getService<T>(_ serviceType: T.Type) -> T
}

class ServiceLocator {
    
}
