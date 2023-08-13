//
//  CoinLogoView.swift
//  Braze
//
//  Created by Roy Aiyetin on 10/10/2022.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    var size: CGFloat = 50
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: size, height: size)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .lineLimit(1)
            
            Text(coin.name)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.theme.secondary)
        .minimumScaleFactor(0.5)
    }
    
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogoView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}
