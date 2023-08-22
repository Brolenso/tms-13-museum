//
//  Router.swift
//  Museum
//
//  Created by Vyacheslav on 11.02.2023.
//

import UIKit

protocol Routing {
    func showLogInViewController(withAnimation: CATransition)
    func showMainViewController(user: User, withAnimation: CATransition)
}

// show ViewControllers created by builder
final class Router: Routing {

    // MARK: Private Properties

    private let moduleBuilder: ModuleBuilding
    private let navigationController: UINavigationController

    // MARK: Initialisers

    init(moduleBuilder: ModuleBuilding, navigationController: UINavigationController) {
        self.moduleBuilder = moduleBuilder
        self.navigationController = navigationController
    }

    // MARK: Public Methods

    func showLogInViewController(withAnimation: CATransition) {
        let logInViewController = moduleBuilder.createLogInModule(router: self)
        navigationController.view.layer.add(withAnimation, forKey: nil)
        navigationController.setViewControllers([logInViewController], animated: false)
    }

    func showMainViewController(user: User, withAnimation: CATransition) {
        let mainViewController = moduleBuilder.createMainModule(router: self, user: user)
        navigationController.view.layer.add(withAnimation, forKey: nil)
        navigationController.setViewControllers([mainViewController], animated: false)
    }

}
