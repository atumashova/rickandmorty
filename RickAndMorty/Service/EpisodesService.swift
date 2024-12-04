//
//  EpisodesService.swift
//  RickAndMorty
//
//  Created by Anna on 03.12.2024.
//

import Foundation

typealias EpisodesResult = Result<[EpisodeModel], Error>

protocol IEpisodesService {
    func getEpisodes(completion: @escaping (EpisodesResult) -> Void)
}

struct EpisodesService: IEpisodesService {
    private let networkService: IHTTPClient
    init(_ dependencies: IDependencies) {
        networkService = dependencies.networkService
    }
    func getEpisodes(completion: @escaping (EpisodesResult) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode") else {return}
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
                    print("data \(data)")
                    let model = try data.decoded() as ResponseEpisode
                    returnedResult = .success(model.results)
                } catch let error {
                    print("error decoded")
                    returnedResult = .failure(error)
                }
            case .failure(let error):
                returnedResult = .failure(error)
            }
        }
    }
}
