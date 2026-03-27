//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Louis Vincelli on 3/26/26.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad URL Response: \(url)"
            case .unknown:
                return "[⚠️] Unknown Error"
            }
        }
    }
    
    // dont need to initialize class can just call networkingmanager.download
    // same function always, if regular func, we need to init an instance of class in order to access download
    static func download(url: URL) -> /*Publishers.ReceiveOn<Publishers.TryMap<Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>, Data>, DispatchQueue>*/
    AnyPublisher<Data, Error>
    {
         //let temp =   it tells you what type it is ^^^
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url) })
//            .tryMap { (output) -> Data in
//                guard let response = output.response as? HTTPURLResponse,
//                      response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//                return output.data
//            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        // converting to any publisher ^^^
    }
    
    // if we want to create second download function this is reusable
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        // throw NetworkingError.badURLResponse(url: url)
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            //throw URLError(.badServerResponse)
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
