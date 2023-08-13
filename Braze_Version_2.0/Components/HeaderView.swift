//
//  HeaderView.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

struct HeaderView: View {
    @State var appear = [false, false, false]
    
    private var text1: String = "30% Commission for"
    private var text2: String = "friends referral"
    private var text3: String = "Transaction fees to earn for"
    private var text4: String = "every trade from a referral"
    
    var body: some View {
        GeometryReader { geometry in
            let scrollY = geometry.frame(in: .named("scroll")).minY
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    VStack(alignment: .leading, spacing: -5) {
                        Text(text1)
                        Text(text2)
                    }
                    .custom(font: .bold, size: isSmallHeight() ? 30:32)
                    
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: -5) {
                    Text(text3)
                    Text(text4)
                }
                .custom(font: .medium, size: isSmallHeight() ? 16:19)

            }
            .foregroundStyle(.white)
            .lineLimit(1)
            .frame(height: scrollY > 0 ? 150 + scrollY : 150)
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .padding(.horizontal, 30)
            .background(
                Image("Background 1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .blur(radius: scrollY / 10 + 4)
            )
            .mask(
                RoundedRectangle(cornerRadius: appear[0] ? 0 : 30, style: .continuous)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            )
        }
        .frame(height: isSmallHeight() ? 150:200)
    }
    
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
