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
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 5/255.0, green: 55/255.0, blue: 115/255.0, alpha: 1.000)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backButtonAppearance.normal.titlePositionAdjustment =
        UIOffset(horizontal: -1000, vertical: 0)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
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
