//
//  MarketDataService.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import Foundation
import Combine

/**
 Service class for retrieving market data.
 
 This class handles fetching and storing global market data.
 */
class MarketDataService: ObservableObject {
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() { // when we initiliaze a coin data service, it initializes and calls func get
        getData()
    }
    
    /**
     Fetches global market data from a remote API.
     
     The function downloads and decodes the data, then updates the `marketData` property.
     */
    func getData() {
        let urlString = "https://api.coingecko.com/api/v3/global"
        
        guard let url = URL(string: urlString) else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder()) //the decode func is specific to this class, because another class may process another kind of data
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (fetchedGlobalData) in
                self?.marketData = fetchedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
