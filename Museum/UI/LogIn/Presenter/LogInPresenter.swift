//
//  LogInPresenter.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import Foundation

protocol LogInViewProtocol: AnyObject {
    
}

protocol LogInPresenterProtocol: AnyObject {
    init(view: LogInViewProtocol, jsonService: JsonServiceProtocol, router: RouterProtocol)
    func loginUser(email: String, password: String)
}

class LogInPresenter: LogInPresenterProtocol {
    weak var view: LogInViewProtocol?
    let jsonService: JsonServiceProtocol
    let router: RouterProtocol
    
    required init(view: LogInViewProtocol, jsonService: JsonServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.jsonService = jsonService
        self.router = router
    }
    
    // show view, than write to JSON
    func loginUser(email: String, password: String) {
        router.showMainViewController(email: email, withAnimation: .fromRight)
        User.current.setUser(email: email, password: password)
        jsonService.write(dataObject: User.current)
    }
}
