//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Louis Vincelli on 3/13/26.
//
// Service Folder is all third party services use in app for example data from coin gecko, or external database or analytics service.

import Foundation
import Combine

class CoinDataService {
    // if @Published if allCoins updated data, all subscribers get updated wiht data.
    @Published var allCoins: [CoinModel] = []
    //var cancellables = Set<AnyCancellable>()
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    // private only accessing from within this class
    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        // Downloading using Combine
        coinSubscription = NetworkingManager.download(url: url)
//        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .default))
//            .tryMap { (output) -> Data in
//                guard let response = output.response as? HTTPURLResponse,
//                      response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//                return output.data
//            }
//            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
        // decode is specific to this function, this url returns us coinmodels but another url might return us some other type of model.
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
        
//            .sink { (completion) in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            } receiveValue: { [weak self] returnedCoins in
//                self?.allCoins = returnedCoins
//                self?.coinSubscription?.cancel()
//            }
        
            //.store(in: &cancellables)
//            .map(\.data)
//            .decode(type: [CoinModel].self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                print(completion)
//            }, receiveValue: { [weak self] coins in
//                self?.allCoins = coins
//            }
    }
    
}
