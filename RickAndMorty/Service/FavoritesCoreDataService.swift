//
//  Untitled.swift
//  RickAndMorty
//
//  Created by Ann on 11.12.2024.
//
import CoreData
typealias FavoritesCoreDataResult = Result<[EpisodeModel]?, Error>
protocol IFavoritesCoreDataSevice {
    func fetch(completion: @escaping (FavoritesCoreDataResult) -> Void)
    func update(episodes: [EpisodeModel])
}

final class FavoritesCoreDataService: IFavoritesCoreDataSevice {
    private let container: NSPersistentContainer
    private let containerName: String = CoreDataConstant.episodeContainerName
    private let entityName: String = CoreDataConstant.episodeEntityName
    private var savedEntities: [EpisodeEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("NSPersistentContainer loadPersistentStores \(error)")
            }
        }
    }
    
    func fetch(completion: @escaping (FavoritesCoreDataResult) -> Void) {
        let request = NSFetchRequest<EpisodeEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
            if !savedEntities.isEmpty {
                let episodes = savedEntities.map { EpisodeModel($0) }
                completion(.success(episodes))
            } else {
                completion(.success(nil))
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func update(episodes: [EpisodeModel]) {
        if !savedEntities.isEmpty {
            delete(entities: savedEntities)
        }
        add(episodes: episodes)
    }
    
    private func add(episodes: [EpisodeModel]) {
        episodes.enumerated().forEach { _, episode in
            EpisodeEntity.make(context: container.viewContext, model: episode)
            applyChanges()
        }
    }
    
    private func delete(entities: [EpisodeEntity]) {
        entities.forEach { entity in
            container.viewContext.delete(entity)
        }
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Save \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        fetch { _ in }
    }
}
