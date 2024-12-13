//
//  UINavigationController.swift
//  RickAndMorty
//
//  Created by Ann on 13.12.2024.
//

import UIKit

extension AppDelegate {
    func setupNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.theme.black,
            .font: UIFont.theme.navigationTitle
        ]
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.tintColor = UIColor.theme.black
    }
}
