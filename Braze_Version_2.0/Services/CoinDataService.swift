//
//  CoinDataService.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import Foundation
import Combine

/**
 Service class for managing coin data.
 
 This class handles fetching and storing coin data from a remote API.
 */
final class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    init() { // when we initiliaze a coin data service, it initializes and calls func get
        getCoins()
    }
    
    /**
     Fetches coin data from a remote API.
     
     The function downloads and decodes the data, then updates the `allCoins` array.
     */
    func getCoins() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=200&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else { return }
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder()) //the decode func is specific to this class, because another class may process another kind of data
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
    
}
