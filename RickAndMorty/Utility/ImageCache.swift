//
//  ImageCache.swift
//  RickAndMorty
//
//  Created by Ann on 08.01.2025.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    private init() {}

    private let cache = NSCache<NSString, UIImage>()

    private let fileManager = FileManager.default
    private lazy var cacheDirectory: URL? = {
        let documentsDirectory = try? fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        return documentsDirectory?.appendingPathComponent("ImageCache")
    }()

    /// Создать для кэша папку
    private func createCacheDirectory() {
        guard let cacheDirectory = cacheDirectory else {
            return
        }
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }

    /// Получить фото из кэша
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    /// Добавить фото в кэш
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    /// Есть ли в кэше картинка
    func isInCache(forKey key: String) -> Bool {
        let cache = cache.object(forKey: key as NSString)
        return cache != nil
    }

    /// Получить фото из кэша на диске
    func getImageFromDiskCache(forKey key: String) -> UIImage? {
        guard let filePath = cacheDirectory?.appendingPathComponent(key).path else {
            return nil
        }
        if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)), let image = UIImage(data: data) {
            return image
        }
        return nil
    }

    /// Добавить в кэш на диск фото
    func setImageToDiskCache(_ image: UIImage, forKey key: String) {
        createCacheDirectory()
        guard let filePath = cacheDirectory?.appendingPathComponent(key).path else {
            return
        }
        if let data = image.pngData() {
            try? data.write(to: URL(fileURLWithPath: filePath))
        }
    }

    /// Очистить кэш
    func clearDiskCache() {
        guard let cacheDirectory = cacheDirectory else {return}
        try? fileManager.removeItem(at: cacheDirectory)
    }
}

extension UIImageView {
    func loadImage(from url: String, contentMode: ContentMode) {
        let cacheKey = url
        if let cachedImage = ImageCache.shared.getImage(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        if let cachedImage = ImageCache.shared.getImageFromDiskCache(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        guard let urlImage = URL(string: url) else {
            setupPlaceholder()
            return
        }
        downloaded(from: urlImage, contentMode: contentMode) { [weak self] result in
            switch result {
            case .success(let image):
                self?.image = image
                ImageCache.shared.setImage(image, forKey: cacheKey)
                ImageCache.shared.setImageToDiskCache(image, forKey: cacheKey)
            case .failure:
                DispatchQueue.main.async {
                    self?.setupPlaceholder()
                }
            }
        }
    }
    private func setupPlaceholder() {
        tintColor = UIColor.black.withAlphaComponent(0.6)
        contentMode = .center
        let configuration = UIImage.SymbolConfiguration(pointSize: 60)
        image = UIImage(systemName: "xmark.circle")?.withConfiguration(configuration)
    }
}
