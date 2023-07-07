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
    func showLogInViewController(withAnimation: CATransition)
    func showMainViewController(email: String, withAnimation: CATransition)
}

// show ViewControllers created by builder
final class Router: RouterProtocol {
    var moduleBuilder: ModuleBuilderProtocol
    var navigationController: UINavigationController
    
    init(moduleBuilder: ModuleBuilderProtocol, navigationController: UINavigationController) {
        self.moduleBuilder = moduleBuilder
        self.navigationController = navigationController
    }
    
    func showLogInViewController(withAnimation: CATransition) {
        let logInViewController = moduleBuilder.createLogInModule(router: self)
        navigationController.view.layer.add(withAnimation, forKey: nil)
        navigationController.setViewControllers([logInViewController], animated: false)
    }
    
    func showMainViewController(email: String, withAnimation: CATransition) {
        let mainViewController = moduleBuilder.createMainModule(router: self, email: email)
        navigationController.view.layer.add(withAnimation, forKey: nil)
        navigationController.setViewControllers([mainViewController], animated: false)
    }

}
