//
//  SceneDelegate.swift
//  Museum
//
//  Created by Vyacheslav on 17.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let rootNavigationController = UINavigationController()
        rootNavigationController.navigationBar.isHidden = true

        let moduleBuilder = ModuleBuilder()
        let router = Router(moduleBuilder: moduleBuilder, navigationController: rootNavigationController)
                
        // if user found in JSON, than show main screen, else show login screen
        if let user = JsonService().read(type: User.self), user.email.count > 0 {
            User.current.setUser(email: user.email, password: user.password)
            router.showMainViewController(email: user.email)
        } else {
            router.showLogInViewController()
        }
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let urlContext = URLContexts.first else { return }
        let url = urlContext.url
        debugPrint("Museum opened from link: \(url.absoluteString)")
    }
}

