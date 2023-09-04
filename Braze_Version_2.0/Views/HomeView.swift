//
//  ContentView.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false // new sheet showing Portfolio View
    @State private var showAddPortfolioView: Bool = false // new sheet to add & edit user portfolio
    @State var showSearchBar: Bool = false
    @State private var isActionSheetPresented = false

    private let userDefaults = UserDefaultManager.shared
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
                        .padding(.horizontal)
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
        .actionSheet(isPresented: $isActionSheetPresented) {
            ActionSheet(title: Text("Choose an option"), buttons: [
                .destructive(Text("Log Out")) {
                    logout()
                },
                .default(Text("Update User")) {
                    updateUser()
                },
                .cancel()
            ])
        }
        
    }
    
    private func logout() {
        isLoggedIn.toggle()
        userDefaults.clearUserData()
    }
    
    private func updateUser() {
        isLoggedIn.toggle()
    }
}

//MARK: PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .preferredColorScheme(.light)
            
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
    }
    
    //MARK: profileRow
    private var profileRow: some View {
        HStack(alignment: .center, spacing: 15) {
            let (storedUsername, storedProfileImageData) = UserDefaultManager.shared.getUserData()
            let image = UIImage(data: storedProfileImageData ?? Data())
            
            Image(uiImage: (image ?? UIImage(systemName: "person.circle.fill")) ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: isSmallHeight() ? size*0.8 : size, height: isSmallHeight() ? size*0.8 : size)
                .clipShape(RoundedRectangle(cornerSize: .init(width: radius, height: radius)))
                .padding(.bottom, isSmallHeight() ? -5:-10)
                .onTapGesture {
                    isActionSheetPresented.toggle()
                }
            
            Text("Welcome, \(storedUsername ?? "Roy")").bold()
                .custom(font: .regular, size: isSmallWidth() ? 16:18)
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
            
            Button(action: {
                showPortfolio.toggle()
            }) {
                Image(systemName: "chart.pie.fill")
                    .font(.system(size:isSmallHeight() ? 25:30))
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
    }
    
    //MARK: priceRow
    private var priceRow: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text(vm.totalPortfolioCoinsStringValue())
                .custom(font: .bold, size: isSmallHeight() ? 30:35)
            
            Text(vm.totalPercentageChange(portfolioCoins: vm.portfolioCoins).asPercentageString())
                .foregroundColor(.black)
                .padding(5)
                .background(Color.green.opacity(0.7))
                .cornerRadius(10)
                .padding(.leading, isSmallWidth() ? 7:10)
                .offset(y: -10)
        }
        .padding(.top, isSmallHeight() ? -9:-12)
        .padding(.bottom,isSmallHeight() ? 1:5)
    }
    
    //MARK: searchbar
    private var searchbar: some View {
        SearchBarView(searchText: $vm.searchText, showSearchBar: $showSearchBar, showPortfolio: $showPortfolio)
            .padding(.top, isSmallHeight() ? 2:4)
            .padding(.leading, 5)
    }
    
    //MARK: statisticsCard
    private var statisticsCard: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 15) {
                ForEach(vm.statistics) { stat in
                    let statCoin = vm.allCoins.first
                    MarketStatisticsCard(stat: stat, coin: statCoin ?? CoinModel.instance)
                }
            }
        }
        .padding(.leading, 16)
    }
    
    //MARK: allCoinsList
    private var allCoinsList: some View {
        LazyVStack {
            ForEach(vm.allCoins) { coin in
                CoinRowViews(coin: coin)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        HStack(spacing: 0) { // Added spacing: 0 to remove any spacing between HStacks
            HStack(alignment: .center) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .frame(maxWidth: .infinity) // Expand to fill available space
            .onTapGesture {
                withAnimation {
                    vm.sortOption = (vm.sortOption == .rank) ? .rankReversed : .rank
                }
            }
            
            Spacer() // Equidistant spacing
            
            HStack(alignment: .center) {
                Text("Last Price")
                Image(systemName: "chevron.down")
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                withAnimation {
                    vm.sortOption = (vm.sortOption == .price) ? .priceReversed : .price
                }
            }
            
            Spacer() // Equidistant spacing
            
            HStack(alignment: .center) {
                Text("24h chg%")
                Image(systemName: "goforward")
                    .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
        }
        .custom(font: .regular, size: isSmallWidth() ? 12 : 14)
        .foregroundColor(.theme.secondary)
        .padding(.top, isSmallHeight() ? 8 : 12)
        .padding(.bottom, isSmallHeight() ? -6 : -8)
    }
    
    
}
