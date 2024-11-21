//
//  AppCoordinator.swift
//  RickAndMorty
//
//  Created by Anna on 21.11.2024.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var dependencies: IDependencies
    
    required init(_ navigationController: UINavigationController, dependencies: IDependencies) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
        self.dependencies = dependencies
    }
    func start() {
        showLaunchViewController()
    }
    
    func showLaunchViewController() {
        
    }
    
    func showMain() {
        
    }
    
}
