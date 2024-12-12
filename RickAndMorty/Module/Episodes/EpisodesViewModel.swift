//
//  EpisodesViewModel.swift
//  RickAndMorty
//
//  Created by Anna on 03.12.2024.
//

import Foundation

protocol EpisodesViewModelDelegate: AnyObject {
    var searchString: String? { get set }
    var updateEpisodesHandler: (([EpisodeModel]) -> Void)? { get set }
    var updateCharacterHandler: ((_ episodeIndex: Int, _ character: CharacterModel) -> Void)? { get set }
    func getEpisodes(nextPage: Bool)
    func getCharacter(episode: EpisodeModel)
    func isFavoriteEpisode(_ episode: EpisodeModel) -> Bool
    func changeEpisodeFavorite(episode: EpisodeModel, isFavorite: Bool)
    func changeSearchValue(_ search: String?, updateSearchRequest: @escaping () -> Void)
}

final class EpisodesViewModel: EpisodesViewModelDelegate {
    var searchString: String?
    var updateCharacterHandler: ((Int, CharacterModel) -> Void)?
    var updateEpisodesHandler: (([EpisodeModel]) -> Void)?
    private var favoriteEpisodes: [EpisodeModel] = []
    private var episodes: [EpisodeModel] = []
    private var isLoadingEpisodes: Bool = false
    private var episodesPageInfo: ResponseInfo?
    private var episodesService: IEpisodesService?
    private let coreDataService: IFavoritesCoreDataSevice
    private var searchTask: DispatchWorkItem?
    
    init(_ dependencies: IDependencies) {
        coreDataService = dependencies.favoritesCoreDataService
        episodesService = dependencies.episodesService
        getFavoriteEpisodes()
    }
    
    func changeSearchValue(_ search: String?, updateSearchRequest: @escaping () -> Void) {
        guard let searchText = search else { return }
        self.searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                DispatchQueue.main.async {
                    self?.searchString = searchText
                    updateSearchRequest()
                }
            }
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
    }
    
    func getCharacter(episode: EpisodeModel) {
        guard let index = episodes.firstIndex(of: episode) else {return}
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
    
    func getEpisodes(nextPage: Bool) {
        guard !isLoadingEpisodes else {
            return
        }
        if !nextPage {
            episodesPageInfo = nil
            episodes = []
        }
        var urlStr = "https://rickandmortyapi.com/api/episode"
        if let pageInfo = episodesPageInfo {
            if let next = pageInfo.next {
                urlStr = next
            } else {
                return
            }
        } else {
            if let searchString = searchString, !searchString.isEmpty {
                if isEpisodeSearchPattern(string: searchString) {
                    urlStr += "?episode=\(searchString)"
                } else {
                    urlStr += "?name=\(searchString)"
                }
            }
        }
        print("getEpisodes episodesService \(urlStr)")
        isLoadingEpisodes = true
        episodesService?.getEpisodes(urlStr: urlStr, completion: { result in
            switch result {
            case .success(let response):
                self.isLoadingEpisodes = false
                self.episodes.append(contentsOf: response.0)
                self.episodesPageInfo = response.1
                self.updateEpisodesHandler?(self.episodes)
            case .failure(let error):
                self.isLoadingEpisodes = false
                self.episodes = []
                self.episodesPageInfo = nil
                self.updateEpisodesHandler?(self.episodes)
                print(error.localizedDescription)
            }
        })
    }
    
    private func getFavoriteEpisodes() {
        coreDataService.fetch { result in
            switch result {
            case .success(let episodes):
                self.favoriteEpisodes = episodes ?? []
            case .failure(let error):
                self.favoriteEpisodes = []
            }
        }
        
    }
    
    private func isEpisodeSearchPattern(string: String) -> Bool {
        let pattern = "^(S(0[1-5])E(0[1-9]|10))|S(0[1-5])|E(0[1-9]|10)$"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: string.utf16.count)
        return regex.firstMatch(in: string, options: [], range: range) != nil
    }
}
