//
//  ServiceLocator.swift
//  Museum
//
//  Created by Vyacheslav on 10.07.2023.
//

protocol ServiceLocating {
    var jsonService: JsonServiceProtocol { get }
    var userRepository: UserRepositoryProtocol { get }
    var eventRepository: EventRepositoryProtocol { get }
}

// all services in one place for the big picture, no shared ServiceLocator object for strong DI in ModuleBuilder
final class ServiceLocator: ServiceLocating {
    lazy var jsonService: JsonServiceProtocol = JsonService()
    lazy var userRepository: UserRepositoryProtocol = UserRepository(jsonService: jsonService)
    lazy var eventRepository: EventRepositoryProtocol = EventRepository()
}
