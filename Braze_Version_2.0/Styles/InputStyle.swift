//
//  InputStyle.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

struct InputStyle: ViewModifier {
    
    var icon: String
    var selectedGradient: LinearGradient = LinearGradient(
                                                        colors: [.theme.purple.opacity(0.5), .theme.blue.opacity(0.5), .theme.purple.opacity(0.5)],
                                                        startPoint: .top, endPoint: .bottom)
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .padding(.leading, 50)
            .strokeStyle(cornerRadius: 20)
            .overlay(
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.secondary)
                    .frame(width: 36, height: 36)
                    .background(selectedGradient, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
            )
    }
}

extension View {
    func inputStyle(icon: String = "mail") -> some View {
        modifier(InputStyle(icon: icon))
    }
}
