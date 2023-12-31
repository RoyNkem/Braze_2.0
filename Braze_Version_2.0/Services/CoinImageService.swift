//
//  CoinImageService.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI
import Combine

/**
 Service class for managing coin images.
 
 This class handles downloading, caching, and storing coin images.
 */
final class CoinImageService {
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = " coin_images"
    private let imageName: String
    
    /**
     Initializes the CoinImageService with a coin model and fetches the associated coin image.
     
     - Parameter coin: The coin model for which the image is fetched.
     */
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    //before we download the coin, check if it has been saved to the filemanager
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage()
            
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard
                    let self = self,
                    let downloadedImage = returnedImage
                else {
                    return
                }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
    
}
