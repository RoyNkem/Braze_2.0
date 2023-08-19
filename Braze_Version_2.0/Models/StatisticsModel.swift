//
//  StatisticsModel.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

/**
 Model class representing statistics information.
 
 Use this class to encapsulate various statistics data with options for percentage change display and associated coin details.
 */
class StatisticsModel: Identifiable {
    
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    let coin: CoinModel?
    let colors: [Color]
    let cardTitle: String
    
    /**
     Custom initializer.
     
     - Parameters:
     - title: Title of the statistic.
     - value: Value associated with the statistic.
     - percentageChange: Percentage change value (optional, default is nil).
     - coin: Associated coin model (optional, default is nil).
     - colors: Colors for visualization.
     - cardTitle: Title for the card containing the statistic.
     */
    init(title: String, value: String, percentageChange: Double? = nil, coin: CoinModel? = nil, colors: [Color], cardTitle: String) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
        self.coin = coin
        self.colors = colors
        self.cardTitle = cardTitle
    }
}


