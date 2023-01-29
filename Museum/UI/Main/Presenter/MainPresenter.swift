//
//  MainPresenter.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func showEmail(email: String)
    func showLogInScreen()
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, jsonService: JsonServiceProtocol, email: String)
    func setEmail()
    func logout()
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var jsonService: JsonServiceProtocol!
    var email: String
    
    required init(view: MainViewProtocol, jsonService: JsonServiceProtocol, email: String) {
        self.view = view
        self.jsonService = jsonService
        self.email = email
    }
    
    func setEmail() {
        view?.showEmail(email: email)
    }
    
    // show view, than write to JSON
    func logout() {
        view?.showLogInScreen()
        let user = User.current
        user.erase()
        jsonService.write(dataObject: user)
    }
}
