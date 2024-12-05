//
//  HTTPClient.swift
//  RickAndMorty
//
//  Created by Anna on 03.12.2024.
//

import Foundation

enum HTTPClientError: Error {
    case invalidServerResponse
    case noResponseData
}

enum HTTPResult {
    case success(Data)
    case failure(Error)
}

protocol IHTTPClient {
    func request(url: URL, completion: @escaping (HTTPResult) -> Void)
}

struct HTTPClient: IHTTPClient {
    func request(url: URL, completion: @escaping (HTTPResult) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            var returnedResult: HTTPResult
            defer {
                completion(returnedResult)
            }
            if let error = error {
                returnedResult = .failure(error)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                returnedResult = .failure(HTTPClientError.invalidServerResponse)
                return
            }
            if let data = data {
                returnedResult = .success(data)
            } else {
                returnedResult = .failure(HTTPClientError.noResponseData)
            }
        }
        task.resume()
    }
}
