//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Louis Vincelli on 3/26/26.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    // hard coding folder name into this specific service.. file
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            //print("Retrieved image from File Manager")
        } else {
            downloadCoinImage()
            //print("Downloading image now")
        }
    }
    
    private func downloadCoinImage() {
        // downloading image as scrolling and opening app.
        // print("Downloading image now")
        guard let url = URL(string: coin.image) else { return }
        
        // Downloading using Combine
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data:data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                // this gets rid of self? below
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
