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
    func showMainViewController()
}

class Router: RouterProtocol {
    var moduleBuilder: ModuleBuilderProtocol
    var navigationController: UINavigationController
    
    init(moduleBuilder: ModuleBuilderProtocol, navigationController: UINavigationController) {
        self.moduleBuilder = moduleBuilder
        self.navigationController = navigationController
    }
    
    func showLogInViewController() {
        
    }
    
    func showMainViewController() {
        
    }

}
