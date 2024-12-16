//
//  CharacterAssembly.swift
//  RickAndMorty
//
//  Created by Ann on 15.12.2024.
//

import UIKit

final class CharacterAssembly {
    static func configure(_ dependencies: IDependencies) -> UIViewController {
        return dependencies.moduleContainer.getCharacterView()
    }
}
