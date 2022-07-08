//
//  SceneDelegate.swift
//  Check24
//
//  Created by Rojin on 7/7/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}

}

