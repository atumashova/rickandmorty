//
//  ResponseInfo.swift
//  RickAndMorty
//
//  Created by Anna on 04.12.2024.
//

import Foundation

struct ResponseInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
