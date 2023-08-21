//
//  ModuleBuilder.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import UIKit

protocol ModuleBuilding {
    func createLogInModule(router: Routing) -> LogInViewController
    func createMainModule(router: Routing, user: User) -> EventViewController
}

// build MVP modules and return UIViewController
final class ModuleBuilder: ModuleBuilding {
    
    // MARK: Constants
    
    private enum Constants {
        static let logInStoryboard = "LogInStoryboard"
        static let logInViewController = "LogInViewController"
        static let eventStoryboard = "EventStoryboard"
        static let eventViewController = "EventViewController"
    }

    // MARK: Private Properties
    
    // all services will be injected from here
    private var userProvider: UserRepositoryProtocol
    private var eventProvider: EventRepositoryProtocol
    
    
    // MARK: Initialisers
    
    init(serviceLocator: ServiceLocating) {
        userProvider = serviceLocator.getUserProvider()
        eventProvider = serviceLocator.getEventProvider()
    }
    
    
    // MARK: Public Properties
    
    func createLogInModule(router: Routing) -> LogInViewController {
        let logInViewController: LogInViewController = UIStoryboard(name: Constants.logInStoryboard, bundle: nil)
            .instantiateViewController(identifier: Constants.logInViewController)
        let presenter = LogInPresenter(view: logInViewController, userProvider: userProvider, router: router)
        logInViewController.presenter = presenter
        return logInViewController
    }
    
    func createMainModule(router: Routing, user: User) -> EventViewController {
        let eventViewController: EventViewController = UIStoryboard(name: Constants.eventStoryboard, bundle: nil)
            .instantiateViewController(identifier: Constants.eventViewController)
        let presenter = EventPresenter(
            view: eventViewController,
            router: router, user: user,
            userProvider: userProvider,
            eventProvider: eventProvider
        )
        eventViewController.presenter = presenter
        return eventViewController
    }
    
}
