//
//  EpisodesViewModel.swift
//  RickAndMorty
//
//  Created by Anna on 03.12.2024.
//

import Foundation

protocol EpisodesViewModelDelegate: AnyObject {
    var updateEpisodesHandler: (([EpisodeModel]) -> Void)? { get set }
    func getEpisodes()
}

final class EpisodesViewModel: EpisodesViewModelDelegate {
    var updateEpisodesHandler: (([EpisodeModel]) -> Void)?
    private var episodes: [EpisodeModel]?
    func getEpisodes() {
        episodesService?.getEpisodes(completion: { result in
            switch result {
            case .success(let episodes):
                self.episodes = episodes
                self.updateEpisodesHandler?(episodes)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private var episodesService: IEpisodesService?
    
    init(_ dependencies: IDependencies) {
        episodesService = dependencies.episodesService
    }
}
