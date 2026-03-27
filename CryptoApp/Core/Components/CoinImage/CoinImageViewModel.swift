//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Louis Vincelli on 3/26/26.
//

import Foundation
import SwiftUI
import Combine

// we have decoupled downloading logic from viewmodel logic so we can reuse download image logic on a bunch of different views now.
class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    //= CoinImageService(urlString: )
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
        //getImage()
    }
    
    private func addSubscribers() {
        // subscribe to published variable image in coin image service
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
    
}
