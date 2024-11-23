//
//  Dependencies.swift
//  RickAndMorty
//
//  Created by Anna on 21.11.2024.
//

import Foundation

protocol IDependencies {
    var moduleContainer: IModuleContainer { get }
//    var episodesService: IEpisodesService { get }
//    var favoritesCoreDataService: IFavoritesCoreDataSevice { get }
}
final class Dependencies: IDependencies {
    lazy var moduleContainer: IModuleContainer = ModuleContainer(self)
}
