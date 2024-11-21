//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Anna on 20.11.2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var coordinator: Coordinator?
    private var dependencies: IDependencies = Dependencies()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let windowScene = window?.windowScene else { return false}
        configureScene(windowScene)
        return true
    }
    private func configureScene(_ windowScene: UIWindowScene) {
        let navController = UINavigationController()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        coordinator = AppCoordinator(navController, dependencies: dependencies)
        coordinator?.start()
    }
}

