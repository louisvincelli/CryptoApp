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
    
    var searchText: String = ""
    
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
        
        // OLD COMBINE CODE: 
        // subscribe to searchText new publisher of type string
        // any time either of these changed its going to publish.
//        $searchText
//            .combineLatest(dataService.$allCoins)
//              debounce waits before running rest of code in order to stop users from typing super fast and making it run x10 times. slight delay after typing.
//            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
//            .map { (text, startingCoins) -> [CoinModel] in
//                guard !text.isEmpty else {
//                    return startingCoins
//                }
//                
//                let lowercasedText = text.lowercased()
//                
//                // not let but return now
//                return filteredCoins = startingCoins.filter { (coin) -> Bool in
//                    return coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText) ||
//                        coin.id.lowercased().contains(lowercasedText)
//                }
//                //return filteredCoins
//            }
//            .sink { [weak self] returnedCoins in
//                self.?allCoins = returnedCoins
//            }
//            .store(in: &cancellables)
        
        var filteredCoins: [CoinModel] {
            let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !text.isEmpty else { return allCoins }
            let lower = text.lowercased()
            return allCoins.filter {
                $0.name.lowercased().contains(lower)
                || $0.symbol.lowercased().contains(lower)
                || $0.id.lowercased().contains(lower)
            }
        }
    }
}
