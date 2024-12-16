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
        let tabbarVC = TabBarAssembly.configure(dependencies)
        if let tabBar = tabbarVC as? UITabBarController {
            tabBar.viewControllers?.forEach({ viewController in
                if let nav = viewController as? UINavigationController, let episodesVC = nav.topViewController as? EpisodesViewController {
                    episodesVC.didSendEventHandler = { [weak self] event in
                        switch event {
                        case .detailCharacter(let character):
                            self?.showCharacterViewController(character, navVC: nav)
                        }
                    }
                }
                if let nav = viewController as? UINavigationController, let favoritesVC = nav.topViewController as? FavoritesViewController {
                    favoritesVC.didSendEventHandler = { [weak self] event in
                        switch event {
                        case .detailCharacter(let character):
                            self?.showCharacterViewController(character, navVC: nav)
                        }
                    }
                }
            })
            
        }
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            window.rootViewController = tabbarVC
            UIView.transition(with: window, duration: 1.0, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        } else {
            tabbarVC.modalPresentationStyle = .fullScreen
            navigationController.show(tabbarVC, sender: self)
        }
    }
    
    func showCharacterViewController(_ character: String?, navVC: UINavigationController) {
        let viewController = CharacterAssembly.configure(dependencies)
        if let characterVC = viewController as? CharacterViewController, let character = character {
            characterVC.setCharacter(character)
        }
        navVC.pushViewController(viewController, animated: true)
    }
}
