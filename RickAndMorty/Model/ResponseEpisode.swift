//
//  EpisodeResponse.swift
//  RickAndMorty
//
//  Created by Anna on 04.12.2024.
//

import Foundation

struct ResponseEpisode: Decodable {
    let info: ResponseInfo
    var results: [ResponseEpisodeModel]
}
struct ResponseEpisodeModel: Decodable, Hashable {
    let id: Int
    var name: String
    var episode: String
    var characters: [String]
}
