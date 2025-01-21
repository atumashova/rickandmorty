//
//  EpisodeEntity.swift
//  RickAndMorty
//
//  Created by Ann on 12.12.2024.
//

import CoreData

extension EpisodeEntity {
    @discardableResult
    static func make(context: NSManagedObjectContext, model: EpisodeModel) -> EpisodeEntity {
        let entity = EpisodeEntity(context: context)
        entity.id = Int32(model.id)
        entity.name = model.name
        entity.episode = model.episode
        entity.character = model.character
        return entity
    }
}
