//
//  UIIimageError.swift
//  RickAndMorty
//
//  Created by Ann on 11.12.2024.
//

import Foundation

// Типы ошибок при скачивании фото
enum ImageDownloadError: Error {
    case invalidURL
    case networkError(Error)
    case badResponse
    case invalidMimeType(String)
    case imageDataCreationError
    case unknown
}
