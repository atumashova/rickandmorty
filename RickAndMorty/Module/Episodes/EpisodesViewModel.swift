//
//  EpisodesViewModel.swift
//  RickAndMorty
//
//  Created by Anna on 03.12.2024.
//

import Foundation

protocol EpisodesViewModelDelegate: AnyObject {
    var updateEpisodesHandler: (([EpisodeModel]) -> Void)? { get set }
    var updateCharacterHandler: ((_ episodeIndex: Int, _ character: CharacterModel) -> Void)? { get set }
    func getEpisodes()
    func getCharacter(episode: EpisodeModel)
}

final class EpisodesViewModel: EpisodesViewModelDelegate {
    var updateCharacterHandler: ((Int, CharacterModel) -> Void)?
    var updateEpisodesHandler: (([EpisodeModel]) -> Void)?
    private var episodes: [EpisodeModel]?
    private var episodesService: IEpisodesService?
    
    init(_ dependencies: IDependencies) {
        episodesService = dependencies.episodesService
    }
    func getCharacter(episode: EpisodeModel) {
        guard let index = episodes?.firstIndex(of: episode) else {return}
        guard let character = episode.character else {return}
        episodesService?.getCharacter(url: character, completion: { result in
            switch result {
            case .success(let character):
                self.updateCharacterHandler?(index, character)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
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
    
}
