//
//  NetworkManager.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import Foundation
import Combine

final class NetworkManager {
    private var subscribers = Set<AnyCancellable>()

    func getRequest<T: Decodable>(with url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlComponents = URLComponents(string: url.absoluteString) else { return }
        
        URLSession.shared
            .dataTaskPublisher(for: urlComponents.url!)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (response) in
                switch response {
                case .failure(let error):
                    completion(.failure(error))
                case .finished: break
                }
            }, receiveValue: { (response) in
                completion(.success(response))
            })
            .store(in: &subscribers)
    }
}
