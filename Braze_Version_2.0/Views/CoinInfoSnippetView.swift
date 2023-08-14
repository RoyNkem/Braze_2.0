//
//  CoinInfoSnippetView.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

struct CoinInfoSnippetView: View {
    
    @Binding var isShowingCard: Bool
    @State private var currentHeight: CGFloat = 350
    @State private var prevDragTranslation = CGSize.zero
    @State private var isDragging: Bool = false
    
    var buttonTitle: String
    let minHeight: CGFloat = 350
    let maxHeight: CGFloat = 500
    let coin: CoinModel
    let size: CGFloat = 80
    
    var clicked: (() -> Void) //closure for callback
    
    let startOpacity: Double = 0.6
    let endOpacity: Double = 0.8
    
    var dragPercentage: Double {
        let result = Double((currentHeight - minHeight) / (maxHeight - minHeight))
        return max(0, min(1, result))
    }
    
    var gradient: LinearGradient = LinearGradient(
        colors: [.orange.opacity(0.5), .theme.purple.opacity(0.5)],
        startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            if isShowingCard {
                Color.black
                    .opacity(startOpacity + (endOpacity - startOpacity) * dragPercentage)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowingCard = false // dismiss sheet when grey arrear is tapped
                    }
                
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowingCard)
    }
    
}


//MARK: - PREVIEW
struct CoinInfoSnippetView_Previews: PreviewProvider {
    static var previews: some View {
        CoinInfoSnippetView(isShowingCard: .constant(true), buttonTitle: "Add to My Portfolio", coin: dev.coin) {
            print("button clicked")
        }
        .preferredColorScheme(.dark)
    }
}

extension CoinInfoSnippetView {
    
    //MARK: mainView
    private var mainView: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 5) {
                VStack {
                    Text(coin.name)
                        .custom(font: .bold, size: 20)
                    
                    Text(coin.symbol.uppercased())
                        .custom(font: .medium, size: 17)
                        .foregroundColor(.theme.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, isSmallHeight() ? 24:30)
                
                //MARK: Coin Description
                //fetch coin summary
                ExpandableText("Bitcoin, a pioneering digital currency, is reshaping how we perceive money. Born in 2009, it's decentralized and operates on blockchain technology. It offers secure, transparent transactions without intermediaries like banks. Bitcoin's scarcity is built into its code, capping supply at 21 million coins. Its value can fluctuate wildly, attracting investors and enthusiasts alike. Bitcoin enables borderless transactions, empowering those without access to traditional banking. While its future is uncertain, its impact on the financial landscape is undeniable.", lineLimit: 2)
                    .foregroundColor(.theme.secondary)
                    .custom(font: .medium, size: 16)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, isSmallWidth() ? 15:20)
                    .padding(.bottom, 10)
                
                //extracted coin data row showing rank, live price and market cap
                coinMarketData
                
                //MARK: Buttons
                VStack(spacing: 10) {
                    Button(action: {
                        //show price history view
                        
                    }) {
                        Text("price history")
                            .foregroundColor(.theme.background)
                            .textCase(.uppercase)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .foregroundColor(.theme.blue)
                            )
                    }
                    .shadow(color: .theme.background.opacity(0.5), radius: 10)
                    
                    LongButton(text: buttonTitle) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                isShowingCard = false
                                self.clicked()
                            }
                        } 
                    }
                }
                .custom(font: .bold, size: isSmallHeight() ? 13:16)
                .padding(.horizontal, isSmallWidth() ? 20:30)

            }
            .frame(height: isSmallHeight() ? currentHeight*0.75 : currentHeight)
            .frame(maxWidth: .infinity)
            .background(Color.theme.homeBackground.opacity(0.8))
            .cornerRadius(30, corners: [.topLeft, .topRight])
            
            //coin image view
            CoinImageView(coin: coin)
                .frame(width: size, height: size)
                .shadow(color: .purple.opacity(0.5) ,radius: 10, y: -5)
                .frame(maxWidth: .infinity)
                .offset(y: -size/2)
                .background(Color.white.opacity(0.01)) //this is important for the dragging
                .gesture(dragGesture)
        }
        .background {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(gradient, lineWidth: isSmallHeight() ? 2:4)
                .shadow(color: .theme.purple, radius: 10, x: 0, y: -5)
                .blur(radius: 2)
        }
        .animation(.easeInOut(duration: 0.5), value: isDragging)
        .onDisappear {
            currentHeight = minHeight
        }
    }
    
    //MARK: dragGesture
    var dragGesture: some Gesture {
        
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                if !isDragging {
                    isDragging = true
                }
                
                let dragAmount = val.translation.height - prevDragTranslation.height
                if currentHeight > maxHeight || currentHeight < minHeight {
                    currentHeight -= dragAmount/6
                } else {
                    currentHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded { val in
                prevDragTranslation = .zero
                isDragging = false
                
                if currentHeight > maxHeight {
                    currentHeight = maxHeight
                } else if currentHeight < minHeight {
                    currentHeight = minHeight
                }
            }
    }
    
    //MARK: Coin Market Data
    private var coinMarketData: some View {
        HStack {
            VStack {
                Text("Rank")
                    .foregroundColor(.theme.secondary)
                    .custom(font: .medium, size: 15)
                Text("top #\(coin.rank)")
                    .custom(font: .bold, size: 20)
            }
            .frame(maxWidth: .infinity)
            Rectangle()
                .frame(width: 1, height: 30)
            
            VStack {
                Text("live price")
                    .foregroundColor(.theme.secondary)
                    .custom(font: .medium, size: 15)
                Text(coin.currentPrice.asCurrencyWithTwoDecimals() )
                    .custom(font: .bold, size: 20)
            }
            .frame(maxWidth: .infinity)
            Rectangle()
                .frame(width: 1, height: 30)
            
            VStack {
                Text("market cap")
                    .foregroundColor(.theme.secondary)
                    .custom(font: .medium, size: 15)
                Text(coin.marketCap?.formattedWithAbbreviations() ?? "")
                    .custom(font: .bold, size: 20)
            }
            .frame(maxWidth: .infinity)
        }
        .textCase(.uppercase)
    }
    
}

