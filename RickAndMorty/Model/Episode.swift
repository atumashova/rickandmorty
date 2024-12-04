//
//  Episode.swift
//  RickAndMorty
//
//  Created by Anna on 30.11.2024.
//

import Foundation

struct EpisodeModel: Decodable, Hashable {
    let id: Int
    var name: String
    var episode: String
    var characters: [String]
}
