//
//  ContentViewModel.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import Combine
import SwiftUI

//observe model from content view
class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticsModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var sortOption: SortOption = .holdings
    @Published var searchText: String = ""
    
    @Published var isLoading: Bool = true
    @Published var isSearchResultEmpty: Bool = false //temp
    
    private var cancellables = Set<AnyCancellable>()
    private let coinDataService = CoinDataService()
    private let portfolioDataService = PortfolioDataService()
    private let marketDataService = MarketDataService()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.addSubscribers()
            self.isLoading = false
        }
    }
    
    //MARK: Subscriptions
    func addSubscribers() {
        
        //data service instance calls the func `get coin` which makes the network request and append the output coin to `allCoins`
        //the received values of coins is stored in the publisher var `allCoins` for home VM to use in home view
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) //publishes the 2 publishers after 0.5 seconds to allow users type tangible texts
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                
                guard let self = self else { return }
                self.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        //update Market Data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData) //transform the returned market data model type to statistics model
            .sink { [weak self] (returnedStats) in
                
                guard let self = self else { return }
                self.statistics = returnedStats
                self.isLoading = false
            }
            .store(in: &cancellables)
        
        //update Portfolio coins. Subscribe to the all coins arr (filtered version)
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    //MARK: FilterAndSortCoins
    private func filterAndSortCoins(text: String, startingCoins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var filteredCoins = filterCoins(text: text, startingCoins: startingCoins)
        sortCoins(sort: sort, coins: &filteredCoins)

        
        return filteredCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort { $0.rank < $1.rank }
        case .rankReversed, .holdingsReversed:
            coins.sort { $0.rank > $1.rank }
        case .price:
            coins.sort { $0.currentPrice < $1.currentPrice }
        case .priceReversed:
            coins.sort { $0.currentPrice > $1.currentPrice }
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // will onlyb sort by holdings
        switch sortOption {
        case .holdings:
            return coins.sorted { $0.currentHoldingsValue > $1.currentHoldingsValue }
        case .holdingsReversed:
            return coins.sorted { $0.currentHoldingsValue < $1.currentHoldingsValue }
        default:
            return coins
        }
    }
    
    //MARK: func filterCoins
    private func filterCoins(text: String, startingCoins: [CoinModel]) -> [CoinModel] {
        
        guard !text.isEmpty else {
            self.isSearchResultEmpty = false
            if !startingCoins.isEmpty {
                self.isSearchResultEmpty = false
            }
            return startingCoins
        }
        
        let lowercasedText = text.lowercased()
        
        let filteredCoins = startingCoins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
            
        for _ in (0..<1) {
            self.isSearchResultEmpty = false
            if filteredCoins.count == 0 {
                self.isSearchResultEmpty = true
            }
        }
        
        return filteredCoins
    }
    
    //MARK: func mapGlobalMarketData
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticsModel] {
        var stats: [StatisticsModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd, colors: [.theme.blue, .theme.purple], cardTitle: "Top Performer")
        
        let volume = StatisticsModel(title: "Total Volume 24h", value: data.volume, colors: [.theme.purple.opacity(0.5), .theme.red], cardTitle: "Circulating Supply")
        
        let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominant, colors: [.theme.blue, .theme.red], cardTitle: "Most Traded Crypto")
                
//        let portfolio = StatisticsModel(title: "Portfolio Value",
//                                        value: totalPortfolioCoinsValue().asCurrencyWithTwoDecimals(),
//                                        percentageChange: totalPercentageChange(portfolioCoins: portfolioCoins),
//                                        colors: [.theme.red, .orange], cardTitle: "Portfolio")
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
//            portfolio
        ])
        return stats
    }
    
    //MARK: Helper Functions PortfolioCoin Calculations
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    func totalPercentageChange(portfolioCoins: [CoinModel]) -> Double {
        //get the price change over 24hrs
        let portfolioVal = totalPortfolioCoinsValue()
        
        let previousVal =
                portfolioCoins
                    .map {(coin) -> Double in
                        let currentVal = coin.currentHoldingsValue
                        let percentChange = (coin.priceChangePercentage24H!)/100
                        let previousVal = currentVal / (1 + percentChange)
                        return previousVal
                    }
                    .reduce(0, +)
        
        let percentageChange = ((portfolioVal - previousVal) / previousVal) * 100
        
        return percentageChange
    }
    
    func totalPortfolioCoinsValue() -> Double {
        
        return portfolioCoins.map { $0.currentHoldingsValue }.reduce(0, +)
    }
    
    func percentageVal(coin: CoinModel) -> String {
        
        let fractionVal = coin.currentHoldingsValue / totalPortfolioCoinsValue()
        let percentVal = fractionVal * 100
        
        return percentVal.asPercentageString()
    }
    
    //MARK: Helper Functions CoreData
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func deleteportfolio(coin: CoinModel) {
        portfolioDataService.deletePortfolio(coin: coin)
    }
    
}
