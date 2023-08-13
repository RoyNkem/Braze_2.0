//
//  StatisticsModel.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

class StatisticsModel: Identifiable {
    
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    let coin: CoinModel?
    let colors: [Color]
    let cardTitle: String
    
    //custom init with percentageChange showing for initializatrion only when needed
    init(title: String, value: String, percentageChange: Double? = nil, coin: CoinModel? = nil, colors: [Color], cardTitle: String) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
        self.coin = coin
        self.colors = colors
        self.cardTitle = cardTitle
    }
}


