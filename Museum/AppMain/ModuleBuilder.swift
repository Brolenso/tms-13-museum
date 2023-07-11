//
//  ModuleBuilder.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import UIKit

protocol ModuleBuilding {
    func createLogInModule(router: Routing) -> LogInViewController
    func createMainModule(router: Routing, user: User) -> MainViewController
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
            .instantiateViewController(identifier: "logInScreen")
        let presenter = LogInPresenter(view: logInViewController, userProvider: userProvider, router: router)
        logInViewController.presenter = presenter
        return logInViewController
    }
    
    func createMainModule(router: Routing, user: User) -> MainViewController {
        let mainViewController: MainViewController = UIStoryboard(name: "MainStoryboard", bundle: nil)
            .instantiateViewController(identifier: "mainScreen")
        let presenter = MainPresenter(view: mainViewController, userProvider: userProvider, router: router, user: user)
        mainViewController.presenter = presenter
        return mainViewController
    }
    
}
