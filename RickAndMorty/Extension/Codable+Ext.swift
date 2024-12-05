//
//  Codable+Ext.swift
//  RickAndMorty
//
//  Created by Anna on 04.12.2024.
//

import Foundation

extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
