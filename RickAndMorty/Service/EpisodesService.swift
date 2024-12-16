//
//  EpisodesService.swift
//  RickAndMorty
//
//  Created by Anna on 03.12.2024.
//

import Foundation

typealias EpisodesResult = Result<([EpisodeModel], ResponseInfo), Error>
typealias CharacterResult = Result<CharacterModel, Error>

protocol IEpisodesService {
    func getEpisodes(urlStr: String, completion: @escaping (EpisodesResult) -> Void)
    func getCharacter(url: String, completion: @escaping (CharacterResult) -> Void)
}

struct EpisodesService: IEpisodesService {
    private let networkService: IHTTPClient
    init(_ dependencies: IDependencies) {
        networkService = dependencies.networkService
    }
    
    func getCharacter(url: String, completion: @escaping (CharacterResult) -> Void) {
        guard let url = URL(string: url) else {return}
        networkService.request(url: url) { result in
            let returnedResult: CharacterResult
            defer {
                DispatchQueue.main.async {
                    completion(returnedResult)
                }
            }
            switch result {
            case .success(let data):
                do {
                    let model = try data.decoded() as CharacterModel
                    returnedResult = .success(model)
                } catch let error {
                    print(error)
                    returnedResult = .failure(error)
                }
            case .failure(let error):
                print(error)
                returnedResult = .failure(error)
            }
        }
    }
    
    func getEpisodes(urlStr: String, completion: @escaping (EpisodesResult) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        networkService.request(url: url) { result in
            let returnedResult: EpisodesResult
            defer {
                DispatchQueue.main.async {
                    completion(returnedResult)
                }
            }
            switch result {
            case .success(let data):
                do {
                    let model = try data.decoded() as ResponseEpisode
                    let episodes = model.results.map({EpisodeModel(id: $0.id, name: $0.name, episode: $0.episode, character: $0.characters.randomElement())})
                    returnedResult = .success((episodes, model.info))
                } catch let error {
                    returnedResult = .failure(error)
                }
            case .failure(let error):
                returnedResult = .failure(error)
            }
        }
    }
}
