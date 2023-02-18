//
//  Router.swift
//  Museum
//
//  Created by Vyacheslav on 11.02.2023.
//

import UIKit

protocol RouterProtocol {
    var moduleBuilder: ModuleBuilderProtocol { get set }
    var navigationController: UINavigationController  { get set }
    func showLogInViewController()
    func showMainViewController(email: String)
}

// show ViewControllers created by builder
class Router: RouterProtocol {
    var moduleBuilder: ModuleBuilderProtocol
    var navigationController: UINavigationController
    
    init(moduleBuilder: ModuleBuilderProtocol, navigationController: UINavigationController) {
        self.moduleBuilder = moduleBuilder
        self.navigationController = navigationController
    }
    
    func showLogInViewController() {
        let logInViewController = moduleBuilder.createLogInModule(router: self)
        navigationController.setViewControllers([logInViewController], animated: true)
    }
    
    func showMainViewController(email: String) {
        let mainViewController = moduleBuilder.createMainModule(router: self, email: email)
        navigationController.setViewControllers([mainViewController], animated: true)
    }

}
