//
//  ModuleBuilder.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createLogInModule() -> UIViewController
    func createMainModule(email: String) -> UIViewController
}

// build MVP modules and return UIViewController
class ModuleBuilder: ModuleBuilderProtocol {
    func createLogInModule() -> UIViewController {
        let jsonService = JsonService()
        let logInViewController: LogInViewController
        logInViewController = UIStoryboard(name: "LogInStoryboard", bundle: nil).instantiateViewController(identifier: "logInScreen")
        let presenter = LogInPresenter(view: logInViewController, jsonService: jsonService)
        logInViewController.presenter = presenter
        return logInViewController
    }
    
    func createMainModule(email: String) -> UIViewController {
        let jsonService = JsonService()
        let mainViewController: MainViewController
        mainViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "mainScreen")
        let presenter = MainPresenter(view: mainViewController, jsonService: jsonService, email: email)
        mainViewController.presenter = presenter
        return mainViewController
    }
}
