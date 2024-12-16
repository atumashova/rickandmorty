//
//  Dependencies.swift
//  RickAndMorty
//
//  Created by Anna on 21.11.2024.
//

import Foundation

protocol IDependencies {
    var moduleContainer: IModuleContainer { get }
    var episodesService: IEpisodesService { get }
    var networkService: IHTTPClient { get }
    var favoritesCoreDataService: IFavoritesCoreDataSevice { get }
}
final class Dependencies: IDependencies {
    lazy var favoritesCoreDataService: IFavoritesCoreDataSevice = FavoritesCoreDataService()
    lazy var networkService: IHTTPClient = HTTPClient()
    lazy var episodesService: IEpisodesService = EpisodesService(self)
    lazy var moduleContainer: IModuleContainer = ModuleContainer(self)
}
