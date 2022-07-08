//
//  AppCoordinator.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    var window: UIWindow!
    
    init(window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        //Fix Nav Bar tint issue in iOS 15.0 or later
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 5/255.0, green: 55/255.0, blue: 115/255.0, alpha: 1.000)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.barTintColor = UIColor(red: 236/255.0, green: 98/255.0, blue: 93/255.0, alpha: 1.000)
            navigationController.navigationBar.tintColor = .white
        }
        
        super.init(navigationController: navigationController)
        self.window = window
    }
    
    override func start() {
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
        
        let coordinator = ProductCoordinator(navigationController: self.navigationController)
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
