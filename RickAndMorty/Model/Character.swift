//
//  Character.swift
//  RickAndMorty
//
//  Created by Anna on 05.12.2024.
//

import Foundation

struct CharacterModel: Decodable {
    let id: Int
    var name: String
    var image: String
    var location: LocationModel
    var gender: String
    var status: String
    var species: String
    var origin: LocationModel
    var type: String
}
extension CharacterModel {
    var info: [CharacterInfo] {
        return [
            CharacterInfo(name: Constants.gender, value: gender),
            CharacterInfo(name: Constants.status, value: status),
            CharacterInfo(name: Constants.specie, value: species),
            CharacterInfo(name: Constants.origin, value: origin.name),
            CharacterInfo(name: Constants.type, value: type),
            CharacterInfo(name: Constants.location, value: location.name),
        ]
    }
}
struct LocationModel: Decodable {
    var name: String
    var url: String
}
struct CharacterInfo: Hashable {
    var name: String
    var value: String
}
