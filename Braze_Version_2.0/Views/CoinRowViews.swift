//
//  CoinROwViews.swift
//  Braze
//
//  Created by Roy Aiyetin on 01/10/2022.
//

import SwiftUI

struct CoinRowViews: View {
    
    private let size: CGFloat = 32.0
    let coin: CoinModel
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            centreColumn
            Spacer()
            rightColumn
        }
        .font(.subheadline)
    }
}


struct CoinROwViews_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowViews(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            
            CoinRowViews(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}


extension CoinRowViews {
    
    //MARK: left Column
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondary)
                .frame(minWidth: 20)
            
            Rectangle()
                .foregroundColor(.theme.background)
                .overlay(CoinImageView(coin: coin))
                .frame(width: size, height: size)
                .cornerRadius(isSmallHeight() ? 8:12)
            
            VStack(alignment: .leading, spacing: -2) {
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .foregroundColor(.accentColor)
                    .lineLimit(1)
                
                Text(coin.name)
                    .custom(font: .regular, size: isSmallHeight() ? 10:13)
                    .foregroundColor(.theme.secondary)
            }
            .padding(.leading, 6)
        }
        .frame(width: UIScreen.main.bounds.width / 3, alignment: .leading)
        
    }
    
    //MARK: centre Column
    private var centreColumn: some View {
        
        Text(coin.currentPrice.asCurrencyWithSixDecimals())
            .bold()
            .foregroundColor(
                (coin.priceChangePercentage24H ?? 0) >= 0 ?
                Color.theme.increaseRate : Color.theme.decreaseRate
            )
            .frame(width: UIScreen.main.bounds.width / 3, alignment: .leading)
        
    }
    
    //MARK: right Column
    private var rightColumn: some View {
        
        Rectangle()
            .frame(width: 80, height: 40)
            .foregroundColor(
                (coin.priceChangePercentage24H ?? 0) >= 0 ?
                Color.theme.increaseRate : Color.theme.decreaseRate
            )
            .cornerRadius(5, corners: .allCorners)
            .overlay {
                Text(coin.priceChangePercentage24H?.asPercentageString() ?? "0")
                    .padding(.all, 10)
                    .foregroundColor(.white)
            }
            .padding(.trailing, isSmallWidth() ? 7:10)
    }
    
}
