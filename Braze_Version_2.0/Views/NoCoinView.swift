//
//  NoCoinView.swift
//  Braze
//
//  Created by Roy Aiyetin on 10/10/2022.
//

import SwiftUI

struct NoCoinView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        LazyHStack {
            LazyVStack {
                Text("We couldn't find any results for \(vm.searchText)...")
                    .custom(font: .bold, size: isSmallHeight() ? 14:16)
                    .lineLimit(1)
                    .padding(.vertical)
                
                Image(systemName: "magnifyingglass")
                    .font(.system(size: isSmallHeight() ? 36:50, weight: .bold))
            }
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 30)
    }
}

struct NoCoinView_Previews: PreviewProvider {
    static var previews: some View {
        NoCoinView()
            .previewLayout(.sizeThatFits)
            .environmentObject(dev.homeVM)
    }
}
