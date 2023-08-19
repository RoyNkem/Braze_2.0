//
//  MarketDataModel.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import Foundation
/*
 URL: https://api.coingecko.com/api/v3/global
 */

/**
 Struct representing global market data.
 */
struct GlobalData: Codable {
    let data: MarketDataModel
}

/**
 Struct representing market data details.
 */
struct MarketDataModel: Codable {
    let markets: Int
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    let updatedAt: Int
    
    /**
     Coding keys to map JSON keys to struct properties.
     */
    enum CodingKeys: String, CodingKey {
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
    
    ///A  string that returns the value of the total market cap in usd
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    ///A  string that returns the value of the total crypto volume in usd
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    /// A  string that returns the percentage amount of BTC in the total market cap
    var btcDominant: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.asPercentageString()
        }
        return ""
    }
    
}

