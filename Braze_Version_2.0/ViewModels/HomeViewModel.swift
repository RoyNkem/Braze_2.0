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
    
    /// Enum representing sorting options for coin list.
    enum SortOption {
        /// Rank-based sorting options.
        case rank, rankReversed
        
        /// Holdings-based sorting options.
        case holdings, holdingsReversed
        
        /// Price-based sorting options.
        case price, priceReversed
    }

    
    init() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.addSubscribers()
            self.isLoading = false
        }
    }
    
    func addSubscribers() {
        
        // MARK: - Update Coin Display
        // This code keeps the list of displayed coins up-to-date by performing the following steps:
        // 1. Observes changes in the searchText, allCoins, and sortOption.
        // 2. Combines these values for processing.
        // 3. Waits for user input to stabilize with a 0.5-second delay.
        // 4. Filters and sorts the coins based on search text and sort preference.
        // 5. Updates the displayed coin list for the view to show.

        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                
                guard let self = self else { return }
                self.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // MARK: - Update Market Statistics
        // This code keeps the market statistics up-to-date with these steps:
        // 1. Watches for changes in market data from the `marketDataService`.
        // 2. Joins market data and portfolio coins using `combineLatest`.
        // 3. Transforms the combined data to convert market data models into statistics models.
        // 4. Subscribes to the transformed data using `sink`, refreshing the view's `statistics` and

        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                // Ensure self is still valid
                guard let self = self else { return }
                
                // Update statistics and isLoading properties
                self.statistics = returnedStats
                self.isLoading = false
            }
            .store(in: &cancellables)
        
        // MARK: - Update Portfolio Coins
        // This code snippet keeps portfolio coins updated using these steps:
        // 1. Observes changes in allCoins and saved portfolio entities.
        // 2. Combines these values for processing.
        // 3. Transforms combined data to map all coins into portfolio coins.
        // 4. Subscribes to the transformed coins using `sink`, updating the view's `portfolioCoins`.
        // 5. Manages subscriptions in the `cancellables` set to avoid memory issues.

        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                // Ensure self is still valid
                guard let self = self else { return }
                
                // Update portfolio coins after sorting
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
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, coin: [CoinModel]?) -> [StatisticsModel] {
        var stats: [StatisticsModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd, colors: [.theme.blue, .theme.purple], cardTitle: "Top Performer")
        
        let volume = StatisticsModel(title: "Total Volume 24h", value: data.volume, colors: [.theme.purple.opacity(0.5), .theme.red], cardTitle: "Circulating Supply")
        
        let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominant, colors: [.theme.blue, .theme.red], cardTitle: "Most Traded Crypto")
                
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
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
