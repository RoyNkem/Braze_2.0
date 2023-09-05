//
//  SearchBarView.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject var vm: HomeViewModel
    @Binding var searchText: String
    @Binding var showSearchBar: Bool
    @Binding var showPortfolio: Bool
        
    var radius: CGFloat = 30.0
    
    var body: some View {
        if self.showSearchBar {
            HStack {
                magnifyingGlassImage
                
                textfield
            }
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.theme.background)
                    .shadow(color: .theme.accentColor.opacity(0.15), radius: 5, x: 1, y: 2)
            )
            .padding(.horizontal)
            .transition(.move(edge: .trailing))
        } else {
            HStack {
                if showPortfolio == false {
                    Text("Live Prices")
                        .custom(font: .bold, size: isSmallWidth() ? 22:24)
                }
                
                Spacer()
                ZStack {
                    Circle()
                        .stroke(LinearGradient(gradient: .init(colors: [.theme.blue,.theme.purple]), startPoint: .leading, endPoint: .trailing), lineWidth: 2.5)
                        .frame(width: radius, height: radius)
                    
                    magnifyingGlassImage
                }
                .padding(.horizontal)
                .onTapGesture {
                    withAnimation {
                        self.showSearchBar = true
                    }
                }
            }
            .padding(.horizontal, isSmallWidth() ? 8:10 )
            .padding(.top, isSmallHeight() ? 16:20)
            .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading).combined(with: .opacity)))
        }
    }
    
}


struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), showSearchBar: .constant(true), showPortfolio: .constant(false))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

extension SearchBarView {
    
    //MARK: MagnifyingGlassImage
    private var magnifyingGlassImage: some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(searchText.isEmpty ? .theme.secondary : .theme.accentColor)
    }
    
    
    //MARK: TextField
    private var textfield: some View {
        TextField(showPortfolio ? "Find coin in portfolio" : "Search by name or symbol...",
                  text: $searchText)
            .custom(font: .regular, size: isSmallWidth() ? 15:18)
            .disableAutocorrection(true)
            .foregroundColor(.theme.accentColor)
            .overlay(alignment: .trailing, content: {
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x:10)
                    .foregroundColor(.theme.purple)
                    .onTapGesture {
                        withAnimation {
                            self.showSearchBar = false
                            self.vm.isSearchResultEmpty = false
                        }
                        UIApplication.shared.didEndEditing()
                        searchText.removeAll()
                    }
            })
    }

}
