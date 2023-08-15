//
//  AddPortfolioView.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

struct AddCoinPortfolioView: View {
    enum Field: Hashable {
        case searchBar
        case coinQuantity
    }
    
    @EnvironmentObject private var vm: HomeViewModel
    @FocusState var focusedField: Field? // enum above
    @State private var selectedCoin: CoinModel? = nil
    @State private var isShowingBottomCard:  Bool = false
    @State private var quantityText: String = ""
    //    @State private var searchBarY: CGFloat = 120
    //    @State private var coinQuantity: CGFloat = 0 // y axis coordinates
    //    @State private var circleY: CGFloat = 120
    @State private var showSaveButton: Bool = false
    
    var selectedGradient: LinearGradient = LinearGradient(
        colors: [.theme.purple, .theme.blue, .theme.purple],
        startPoint: .leading, endPoint: .trailing)
    
    var clearGradient: LinearGradient = LinearGradient(colors: [.clear], startPoint: .bottom, endPoint: .top)
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading){
                    HeaderView()
                    
                    VStack(alignment: .leading) {
                        editPortfolioText
                        searchBar
                        noCoinFound //conditional View that shows when there are no coin results
                        coinLogoList //scrollView that enables selection of coin after network request
                        
                        if selectedCoin != nil { //show field calculator
                            inputCoinQuantityField
                        }
                    }
                    .padding(.vertical)
                    
                }
            }
            .coordinateSpace(name: "scroll")
            .background(Color.theme.homeBackground.opacity(0.3))
            .ignoresSafeArea(.container, edges: .top)
            .onChange(of: vm.searchText) { value in
                if value == "" {
                    removeSelectedCoin()
                }
            }
            
            XMarkButton()
            
            CoinInfoSnippetView(isShowingCard: $isShowingBottomCard,
                                buttonTitle: isCoinInPortfolio() ? "Remove from Portfolio" : "Add to Portfolio",
                                coin: (selectedCoin ?? (vm.allCoins.first)) ?? CoinModel.instance) {
                
                //remove selected coin from portfolio in Core Data stacks
                if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == selectedCoin?.id }) {
                    vm.deleteportfolio(coin: portfolioCoin)
                }
            }
        }
    }
    
}


//MARK: - PREVIEW
struct AddCoinPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoinPortfolioView()
            .preferredColorScheme(.dark)
            .environmentObject(dev.homeVM)
    }
}

extension AddCoinPortfolioView {
    
    //MARK: editPortfolioText
    private var editPortfolioText: some View {
        
        HStack {
            Text("Edit Portfolio")
                .custom(font: .bold, size: 30)
            
            Spacer()
            
            SaveButtonAnimated() {
                saveButtonPressed()
            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0:0.0) //show button if coin is selected and coin quantity is entered
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
    
    //MARK: searchBar
    private var searchBar: some View {
        SearchBarView(searchText: $vm.searchText, showSearchBar: .constant(true), showPortfolio: .constant(false))
            .padding(.bottom, isSmallHeight() ? 12:16)
    }
    
    //MARK: coinLogoList
    private var coinLogoList: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(5)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.5)) {
                                selectedCoin = coin
                                isShowingBottomCard = true
                            }
                            UIApplication.shared.didEndEditing()
                        }
                        .background(
                            RoundedRectangle(cornerRadius: isSmallHeight() ? 12:14)
                                .stroke(selectedCoin?.id == coin.id ?
                                        selectedGradient : clearGradient,
                                        lineWidth: isSmallHeight() ? 1.5:2.5
                                       )
                        )
                }
            }
            .padding(.leading)
        }
    }
    
    //MARK: addCoinQuantityTextField
    private var addCoinQuantityField: some View {
        VStack(spacing: isSmallHeight() ? 12:20) {
            TextField(textFieldPlaceholder(), text: $quantityText)
                .custom(font: .medium, size: isSmallHeight() ? 15:18)
                .foregroundColor( isCoinInPortfolio() ? .black.opacity(0.5) : .accentColor) //  change the color of the text if the coin is saved in Core Data Stacks
                .inputStyle(icon: "mail")
                .keyboardType(.decimalPad)
                .disableAutocorrection(true)
                .shadow(color: focusedField == .coinQuantity ? .primary.opacity(0.3) : .primary.opacity(0.3), radius: 10, x: 1, y: 3)
            
            HStack {
                Text("Current Value of Quantity added:")
                Spacer()
                Text(getCurrentValue().asCurrencyWithTwoDecimals())
                    .bold()
            }
        }
    }
    
    //MARK: Helper functions
    private func textFieldPlaceholder() -> String {
        if isCoinInPortfolio() {
            return "You are holding \(selectedCoin?.currentHoldings ?? 0) vol of \(selectedCoin?.symbol.uppercased() ?? "")"
        } else {
            return "Enter Coin Quantity to add"
        }
    }
    
    private func isCoinInPortfolio() -> Bool {
        return vm.portfolioCoins.contains(where: { $0.id == selectedCoin?.id })
    }
    
    private var geometry: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: CirclePreferenceKey.self, value: proxy.frame(in: .named("container")).minY)
        } //color.clear wont make view appear and will keep the layout
    }
    
    //MARK: noCoinFound
    private var noCoinFound: some View {
        
        LazyVStack {
            if vm.isSearchResultEmpty {
                NoCoinView()
                    .environmentObject(vm)
            }
        }
    }
    
    //MARK: func getCurrentValue
    
    /// Calculates the current value of selected coin based on the quantity or volume of coin entered in inputField.
    /// - Returns: returns the value of the quantity entered
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    //MARK: inputCoinQuantity
    private var inputCoinQuantityField: some View {
        VStack {
            HStack {
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWithTwoDecimals() ?? "")
                    .bold()
            }
            addCoinQuantityField
        }
        .padding(isSmallHeight() ? 12:17)
        .custom(font: .medium, size: isSmallHeight() ? 13:16)
    }
    
    private func saveButtonPressed() {
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        //show save Button
        withAnimation(.easeIn) {
            removeSelectedCoin()
        }
        
        //hide keyboard
        UIApplication.shared.didEndEditing()
        
        //hide save button
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            withAnimation {
                showSaveButton =  false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
