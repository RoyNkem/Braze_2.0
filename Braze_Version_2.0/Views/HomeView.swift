//
//  ContentView.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false // new sheet showing Portfolio View
    @State private var showAddPortfolioView: Bool = false // new sheet to add & edit user portfolio
    @State var showSearchBar: Bool = false
    
    private let rows: [GridItem]  = Array(repeating: GridItem(.adaptive(minimum: 200), spacing: 15), count: 1)
    private var radius: CGFloat = 25.0
    var size: CGFloat = 50
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                topSection
                
                searchbar
                
                if showPortfolio == false {
                    if showSearchBar == false {
                        statisticsCard
                    }
                }
                
                if vm.isSearchResultEmpty {
                    NoCoinView()
                        .environmentObject(vm)
                }
                
                if showPortfolio == false {
                    if !vm.allCoins.isEmpty {
                        columnTitles
                    }
                    allCoinsList
                        .transition(.move(edge: .trailing))
                } else {
                    portfolioCoinsList
                        .transition(.asymmetric(insertion: .move(edge: .leading),
                                                removal: .move(edge: .leading).combined(with: .opacity))
                        )
                }
            }
            .sheet(isPresented: $showAddPortfolioView) {
                AddCoinPortfolioView()
                    .environmentObject(vm)
            }
        }
        .background(Color.theme.homeBackground.opacity(0.3))
        .ignoresSafeArea(.container, edges: .top)
    }
    
}

//MARK: PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(dev.homeVM)
    }
    
}

extension HomeView {
    
    //MARK: topSection
    private var topSection: some View {
        VStack(alignment: .leading) {
            
            profileRow
            Text("Wallet(USD)")
                .foregroundColor(.white.opacity(0.7))
            priceRow
            buttonRow
            Spacer()
            
        }
        .padding(.top, isSmallHeight() ? 25 : 50)
        .padding(.horizontal)
        .padding(.vertical, isSmallHeight() ? 6:8)
        .foregroundColor(.white)
        .font(.system(size: isSmallHeight() ? 11 : 13))
        .background(LinearGradient(colors: [Color.theme.blue, Color.theme.purple], startPoint: .leading, endPoint: .trailing))
        .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
    }
    
    //MARK: profileRow
    private var profileRow: some View {
        HStack(spacing: 15) {
            Image("avatar")
                .resizable()
                .scaledToFill()
                .frame(width: isSmallHeight() ? size*0.8 : size, height: isSmallHeight() ? size*0.8 : size)
                .clipShape(RoundedRectangle(cornerSize: .init(width: radius, height: radius)))
//                .overlay(content: {
//                    RoundedRectangle(cornerRadius: radius/2)
//                        .stroke(Color.white, lineWidth: 1)
//                })
                .padding(.bottom, isSmallHeight() ? -5:-10)
            
            Text("Hello, Roy").bold()
                .font(.system(size: isSmallHeight() ? 14:16))
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
            
            Button(action: {
                showPortfolio.toggle()
            }) {
                Image(systemName: "chart.pie.fill")
                    .font(.system(size:isSmallHeight() ? 23:28))
                    .foregroundColor(.white)
                    .shadow(radius: 10, x: 2, y: 4)
            }
        }
        .padding(.bottom, isSmallHeight() ? 10:16)
    }
    
    //MARK: buttonRow
    private var buttonRow: some View {
        HStack {
            ProfileButtons(icon: "plus", text: "Add") {
                showAddPortfolioView = true
            }
            
            Spacer()
            ProfileButtons(icon: "line.diagonal.arrow", text: "Send") {
                //perform send button action
                
            }
            Spacer()
            ProfileButtons(icon: "arrow.down", text: "Request") {
                //perform request button action
                
            }
            Spacer()
            ProfileButtons(icon: "menubar.dock.rectangle", text: "Bill") {
                //perform wallet button action
                
            }
        }
        .padding(.horizontal, isSmallHeight() ? 9:12)
    }
    
    //MARK: priceRow
    private var priceRow: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text(vm.totalPortfolioCoinsValue().asCurrencyWithTwoDecimals())
                .custom(font: .bold, size: isSmallHeight() ? 30:35)
            
            Text(vm.totalPercentageChange(portfolioCoins: vm.portfolioCoins).asPercentageString())
                .foregroundColor(.black)
                .padding(5)
                .background(Color.green.opacity(0.7))
                .cornerRadius(10)
                .padding(.leading)
                .offset(y: -10)
        }
        .padding(.top, isSmallHeight() ? -9:-12)
        .padding(.bottom,isSmallHeight() ? 1:5)
    }
    
    //MARK: searchbar
    private var searchbar: some View {
        SearchBarView(searchText: $vm.searchText, showSearchBar: $showSearchBar, showPortfolio: $showPortfolio)
            .padding(.top, isSmallHeight() ? 2:4)
            .padding(.horizontal, 5)
    }
    
    //MARK: statisticsCard
    private var statisticsCard: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 15) {
                ForEach(vm.statistics) { stat in
                    MarketStatisticsCard(cardTitle: stat.cardTitle, marketValue: stat.value, stat: stat, coin: CoinModel.instance, colors: stat.colors)
                }
            }
        }
        .padding(.leading)
    }
    
    //MARK: allCoinsList
    private var allCoinsList: some View {
        LazyVStack {
            ForEach(vm.allCoins) { coin in
                CoinRowViews(coin: coin)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, isSmallHeight() ? 6:8)
        .padding(.vertical, isSmallHeight() ? 7:10)
    }
    
    //MARK: portfolioCoinsList
    private var portfolioCoinsList: some View {
        LazyVStack(alignment: .leading) {
            
            HStack(alignment: .bottom) {
                Text("Portfolio")
                    .custom(font: .bold, size: 30)
                    .font(.system(size: isSmallHeight() ? 23:30, weight: .bold, design: .rounded))
                    .padding(.bottom, -6)
                
                Spacer()
                
                HStack() {
                    Text("Sort by")
                    Image(systemName: "chevron.down")
                        .opacity(vm.sortOption == .holdings || vm.sortOption == .holdingsReversed ? 1.0:0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0:180))
                }
                .custom(font: .regular, size: 15)
                .onTapGesture {
                    withAnimation {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            
            ForEach(vm.portfolioCoins) { coin in
                //order the  coin arrangement
                PortfolioRowViews(text: vm.percentageVal(coin: coin)  + " of portfolio" , coin: coin)
                    .animation(.spring(response: 10.0, dampingFraction: 0.5), value: vm.sortOption)
            }
        }
        .padding(.horizontal, isSmallHeight() ? 12:14)
        .padding(.top, isSmallHeight() ? 5:8)
    }
    
    //MARK: columnTitles
    private var columnTitles: some View {
        
        HStack {
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .rank || vm.sortOption == .rankReversed ? 1.0:0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0:180))
            }
            .offset(x: 25)
            .frame(width: UIScreen.main.bounds.width / 3, alignment: .leading)
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }

            Spacer()
            
            HStack {
                Text("Last Price")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .price || vm.sortOption == .priceReversed ? 1.0:0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0:180))
            }
            .offset(x: isSmallHeight() ? 15:20)
            .frame(width: UIScreen.main.bounds.width / 3, alignment: .leading)
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            HStack(spacing: 5) {
                Text("24h chg%")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                Image(systemName: "goforward")
                    .rotationEffect(Angle(degrees: vm.isLoading ? 360:0), anchor: .center)
                    .font(.caption)
            }
            .offset(x: -20)
            .frame(width: UIScreen.main.bounds.width / 3, alignment: .leading)

        }
        .custom(font: .regular, size: isSmallWidth() ? 12:14)
        .foregroundColor(.theme.secondary)
        .padding(.top, isSmallHeight() ? 8:12)
        .padding(.bottom, isSmallHeight() ? -6:-8)
    }
    
}
