//
//  UIImageView+Download.swift
//  RickAndMorty
//
//  Created by Anna on 05.12.2024.
//

import Foundation
import UIKit
// Типы ошибок при скачивании фото
enum ImageDownloadError: Error {
    case invalidURL
    case networkError(Error)
    case badResponse
    case invalidMimeType(String)
    case imageDataCreationError
    case unknown
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping (Result<UIImage, ImageDownloadError>) -> Void) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
                completion(.failure(.badResponse))
                return
            }
            guard let mimeType = response?.mimeType, mimeType.hasPrefix("image") else {
                completion(.failure(.invalidMimeType(response?.mimeType ?? "неизвестно")))
                return
            }
            guard let data = data else {
                completion(.failure(.imageDataCreationError))
                return
            }
            guard let image = UIImage(data: data) else {
                completion(.failure(.imageDataCreationError))
                return
            }
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode) { [weak self] result in
            switch result {
            case .success(let image):
                self?.image = image
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.tintColor = UIColor.black.withAlphaComponent(0.6)
                    self?.contentMode = .center
                    let configuration = UIImage.SymbolConfiguration(pointSize: 60)
                    self?.image = UIImage(systemName: "xmark.circle")?.withConfiguration(configuration)
                }
            }
        }
    }
}
