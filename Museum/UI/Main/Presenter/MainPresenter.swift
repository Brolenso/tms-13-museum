//
//  MainPresenter.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func showEmail(email: String)
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, jsonService: JsonServiceProtocol, router: RouterProtocol, email: String)
    func setEmail()
    func logout()
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    let jsonService: JsonServiceProtocol
    let router: RouterProtocol
    var email: String
    
    required init(view: MainViewProtocol, jsonService: JsonServiceProtocol, router: RouterProtocol, email: String) {
        self.view = view
        self.jsonService = jsonService
        self.router = router
        self.email = email
    }
    
    func setEmail() {
        view?.showEmail(email: email)
    }
    
    // show view, than write to JSON
    func logout() {
        router.showLogInViewController()
        let user = User.current
        user.erase()
        jsonService.write(dataObject: user)
    }
}
