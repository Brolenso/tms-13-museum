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

    // all services will be injected from here
    private let serviceLocator: any ServiceLocating
    private lazy var userProvider = serviceLocator.getUserProvider()
    
    init(serviceLocator: any ServiceLocating) {
        self.serviceLocator = serviceLocator
    }
    
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
        let presenter = EventPresenter(view: mainViewController, userProvider: userProvider, router: router, user: user)
        mainViewController.presenter = presenter
        return mainViewController
    }
    
}
