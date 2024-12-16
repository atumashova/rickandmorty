//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Ann on 16.12.2024.
//

protocol CharacterViewModelDelegate: AnyObject {
    var updateCharacterHandler: ((CharacterModel) -> Void)? { get set }
    func getCharacter(character: String)
}

final class CharacterViewModel: CharacterViewModelDelegate {
    var updateCharacterHandler: ((CharacterModel) -> Void)?
    private var characterModel: CharacterModel?
    private var isLoadingEpisodes: Bool = false
    private var episodesService: IEpisodesService?
    
    init(_ dependencies: IDependencies) {
        episodesService = dependencies.episodesService
    }
    
    func getCharacter(character: String) {
        episodesService?.getCharacter(url: character, completion: { result in
            switch result {
            case .success(let character):
                self.characterModel = character
                self.updateCharacterHandler?(character)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
