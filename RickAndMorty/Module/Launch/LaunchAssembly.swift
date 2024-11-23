//
//  LaunchAssembly.swift
//  RickAndMorty
//
//  Created by Anna on 23.11.2024.
//

import Foundation
import UIKit

final class LaunchAssembly {
    static func configure(_ dependencies: IDependencies) -> UIViewController {
        return dependencies.moduleContainer.getLaunchView()
    }
}
