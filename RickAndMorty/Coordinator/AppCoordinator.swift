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
        let launchViewController = LaunchAssembly.configure(dependencies)
        navigationController.show(launchViewController, sender: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            self?.showMain()
        }
    }
    
    func showMain() {
        
    }
    
}
