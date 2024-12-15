//
//  ModuleContainer.swift
//  RickAndMorty
//
//  Created by Anna on 22.11.2024.
//

import Foundation
import UIKit

protocol IModuleContainer {
    func getLaunchView() -> UIViewController
    func getTabBar() -> UIViewController
    func getEpisodesView() -> UIViewController
    func getFavoritesView() -> UIViewController
    func getCharacterView() -> UIViewController
}

final class ModuleContainer: IModuleContainer {
    private let dependencies: IDependencies
    required init(_ dependencies: IDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - Launch
extension ModuleContainer {
    func getLaunchView() -> UIViewController {
        return LaunchViewController()
    }
}

// MARK: - TabBar
extension ModuleContainer {
    func getTabBar() -> UIViewController {
        let episodesVC = EpisodesAssembly.configure(dependencies)
        episodesVC.tabBarItem.image = UIImage(named: Images.tabbarHome)
        episodesVC.tabBarItem.selectedImage = UIImage(named: Images.tabbarHomeSelected)
        let favoritesVC = FavoritesAssembly.configure(dependencies)
        favoritesVC.tabBarItem.image = UIImage(named: Images.tabbarFavorites)
        favoritesVC.tabBarItem.selectedImage = UIImage(named: Images.tabbarFavoritesSelected)
        let view = TabBarController(controllers: [episodesVC, favoritesVC])
        view.startIndex = 0
        return view
    }
}
// MARK: - Character
extension ModuleContainer {
    func getCharacterView() -> UIViewController {
        let view = CharacterViewController()
        return view
    }
}
// MARK: - Episodes
extension ModuleContainer {
    func getEpisodesView() -> UIViewController {
        let view = EpisodesViewController()
        let navigation = UINavigationController(rootViewController: view)
        let viewModel = EpisodesViewModel(dependencies)
        view.viewModel = viewModel
        return navigation
    }
}

// MARK: - Favorites
extension ModuleContainer {
    func getFavoritesView() -> UIViewController {
        let view = FavoritesViewController()
        let navigation = UINavigationController(rootViewController: view)
        let viewModel = FavoritesViewModel(dependencies)
        view.viewModel = viewModel
        return navigation
    }
}
