//
//  LogInPresenter.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import Foundation

protocol LogInViewProtocol: AnyObject {
    func showMainScreen(email: String)
}

protocol LogInPresenterProtocol: AnyObject {
    init(view: LogInViewProtocol, jsonService: JsonServiceProtocol)
    func loginUser(email: String, password: String)
}

class LogInPresenter: LogInPresenterProtocol {
    weak var view: LogInViewProtocol?
    var jsonService: JsonServiceProtocol!
    
    required init(view: LogInViewProtocol, jsonService: JsonServiceProtocol) {
        self.view = view
        self.jsonService = jsonService
    }
    
    // show view, than write to JSON
    func loginUser(email: String, password: String) {
        view?.showMainScreen(email: email)
        User.current.setUser(email: email, password: password)
        jsonService.write(dataObject: User.current)
    }
}
