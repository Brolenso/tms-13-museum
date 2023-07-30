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
        let logInViewController: LogInViewController = UIStoryboard(name: "LogInStoryboard", bundle: nil)
            .instantiateViewController(identifier: "LogInStoryboard")
        let presenter = LogInPresenter(view: logInViewController, userProvider: userProvider, router: router)
        logInViewController.presenter = presenter
        return logInViewController
    }
    
    func createMainModule(router: Routing, user: User) -> EventViewController {
        let mainViewController: EventViewController = UIStoryboard(name: "EventStoryboard", bundle: nil)
            .instantiateViewController(identifier: "EventStoryboard")
        let presenter = EventPresenter(view: mainViewController, router: router, user: user, userProvider: userProvider, eventProvider: eventProvider)
        mainViewController.presenter = presenter
        return mainViewController
    }
    
}
