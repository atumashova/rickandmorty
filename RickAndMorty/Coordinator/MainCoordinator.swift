//
//  MainCoordinator.swift
//  RickAndMorty
//
//  Created by Anna on 21.11.2024.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var dependencies: IDependencies
    
    required init(_ navigationController: UINavigationController, dependencies: IDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showTabBarViewController()
    }
    
    private func showTabBarViewController() {
        
    }
    
    func showCharacterViewController() {
        
    }
}
