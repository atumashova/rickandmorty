//
//  FavoritesViewModel.swift
//  RickAndMorty
//
//  Created by Ann on 13.12.2024.
//

protocol FavoritesViewModelDelegate: AnyObject {
    var updateFavoritesEpisodesHandler: (([EpisodeModel]) -> Void)? { get set }
    var updateCharacterHandler: ((_ episodeIndex: Int, _ character: CharacterModel) -> Void)? { get set }
    func getCharacter(episode: EpisodeModel)
    func getFavoriteEpisodes()
    func isFavoriteEpisode(_ episode: EpisodeModel) -> Bool
    func changeEpisodeFavorite(episode: EpisodeModel, isFavorite: Bool)
}

final class FavoritesViewModel: FavoritesViewModelDelegate {
    var updateCharacterHandler: ((Int, CharacterModel) -> Void)?
    var updateFavoritesEpisodesHandler: (([EpisodeModel]) -> Void)?
    private var favoriteEpisodes: [EpisodeModel] = []
    private var isLoadingEpisodes: Bool = false
    private var episodesService: IEpisodesService?
    private let coreDataService: IFavoritesCoreDataSevice
    init(_ dependencies: IDependencies) {
        coreDataService = dependencies.favoritesCoreDataService
        episodesService = dependencies.episodesService
        getFavoriteEpisodes()
    }
    
    func getCharacter(episode: EpisodeModel) {
        guard let index = favoriteEpisodes.firstIndex(of: episode) else {return}
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
    
    func isFavoriteEpisode(_ episode: EpisodeModel) -> Bool {
        favoriteEpisodes.contains(where: {$0.id == episode.id})
    }
    
    func changeEpisodeFavorite(episode: EpisodeModel, isFavorite: Bool) {
        if isFavorite {
            // удалить из избранных
            favoriteEpisodes.removeAll(where: {$0.id == episode.id})
            coreDataService.update(episodes: favoriteEpisodes)
        } else {
            // добавить в избранное
            favoriteEpisodes.append(episode)
            coreDataService.update(episodes: favoriteEpisodes)
        }
    }
    
    func getFavoriteEpisodes() {
        coreDataService.fetch { result in
            switch result {
            case .success(let episodes):
                self.favoriteEpisodes = episodes ?? []
                self.updateFavoritesEpisodesHandler?(self.favoriteEpisodes)
            case .failure(let error):
                self.favoriteEpisodes = []
                self.updateFavoritesEpisodesHandler?([])
            }
        }
        
    }
}
