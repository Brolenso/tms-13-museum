//
//  SceneDelegate.swift
//  Museum
//
//  Created by Vyacheslav on 17.12.2022.
//

// TODO: EventService

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let serviceLocator: any ServiceLocating = ServiceLocator()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let rootNavigationController = UINavigationController()
        rootNavigationController.navigationBar.isHidden = true

        let moduleBuilder = ModuleBuilder(serviceLocator: serviceLocator)
        let router = Router(moduleBuilder: moduleBuilder, navigationController: rootNavigationController)
                
        // if user found in JSON, than show main screen, else show login screen
        let userProvider = serviceLocator.getUserProvider()
        if let user = userProvider.getUser(), user.email.count > 0 {
            router.showMainViewController(user: user, withAnimation: .systemDefault)
        } else {
            router.showLogInViewController(withAnimation: .systemDefault)
        }
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    // deep link opening
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let urlContext = URLContexts.first else { return }
        let url = urlContext.url
        print("Museum opened from link: \(url.absoluteString)")
    }
        
}

