//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Louis Vincelli on 3/4/26.
//

import Foundation
import Combine

@Observable class HomeViewModel {
    var allCoins: [CoinModel] = []
    var portfolioCoins: [CoinModel] = []
    
    // initializing new CoinDataService right here
    private let dataService = CoinDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.allCoins.append(DeveloperPreview.instance.coin)
//            self.portfolioCoins.append(DeveloperPreview.instance.coin)
//        }
    }
    
    func addSubscribers() {
        // its the oen in CoinDataService and this will get notified and get same values, once we append to coindataservice it will publish that value into this subscriber.
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
