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
