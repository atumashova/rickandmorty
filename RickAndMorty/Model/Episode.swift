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
    var character: String?
}
// MARK: COREDATA
extension EpisodeModel {
    init(_ entity: EpisodeEntity) {
        id = Int(entity.id)
        name = entity.name ?? ""
        episode = entity.episode ?? ""
        character = entity.character ?? ""
    }
}
