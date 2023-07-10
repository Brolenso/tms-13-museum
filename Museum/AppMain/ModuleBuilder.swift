//
//  ModuleBuilder.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import UIKit

protocol ModuleBuilding {
    func createLogInModule(router: Routing) -> UIViewController
    func createMainModule(router: Routing, email: String) -> UIViewController
}

// build MVP modules and return UIViewController
final class ModuleBuilder: ModuleBuilding {

    private let jsonService: JsonService
    
    init(jsonService: JsonService) {
        self.jsonService = jsonService
    }
    
    func createLogInModule(router: Routing) -> UIViewController {
        let logInViewController: LogInViewController
        logInViewController = UIStoryboard(name: "LogInStoryboard", bundle: nil).instantiateViewController(identifier: "logInScreen")
        let presenter = LogInPresenter(view: logInViewController, jsonService: jsonService, router: router)
        logInViewController.presenter = presenter
        return logInViewController
    }
    
    func createMainModule(router: Routing, email: String) -> UIViewController {
        let mainViewController: MainViewController
        mainViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "mainScreen")
        let presenter = MainPresenter(view: mainViewController, jsonService: jsonService, router: router, email: email)
        mainViewController.presenter = presenter
        return mainViewController
    }
    
}
