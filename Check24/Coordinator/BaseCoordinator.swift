//
//  BaseCoordinator.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//


import UIKit

class BaseCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        fatalError("Start method must be implemented")
    }
 
    func start(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            print("Removed \(coordinator.self)")
            self.childCoordinators.remove(at: index)
        }
    }
}
