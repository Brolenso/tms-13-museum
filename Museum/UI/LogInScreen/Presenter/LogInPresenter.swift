//
//  LogInPresenter.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import Foundation

protocol LogInPresenterProtocol: AnyObject {
    init(view: LogInViewProtocol, userProvider: UserRepositoryProtocol, router: Routing)
    func loginUser(email: String, password: String)
}

final class LogInPresenter: LogInPresenterProtocol {
    
    // MARK: Private Properties
    
    private weak var view: LogInViewProtocol?
    private let userProvider: UserRepositoryProtocol
    private let router: Routing
    
    
    // MARK: Initialisers
    
    required init(view: LogInViewProtocol, userProvider: UserRepositoryProtocol, router: Routing) {
        self.view = view
        self.userProvider = userProvider
        self.router = router
    }
    
    
    // MARK: Public Methods
    
    // show view, than write to JSON
    func loginUser(email: String, password: String) {
        let user = User(email: email, password: password)
        router.showMainViewController(user: user, withAnimation: .fromRight)
        userProvider.setUser(user: user)
    }
    
}
