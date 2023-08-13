//
//  StrokeStyle.swift
//  Braze
//
//  Created by Roy Aiyetin on 10/10/2022.
//

import SwiftUI

struct StrokeModifier: ViewModifier {
    var cornerRadius: CGFloat
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(
                    .linearGradient(
                        colors: [
                            .black.opacity(colorScheme == .dark ? 0.2 : 0.1),
                            .black.opacity(colorScheme == .dark ? 0.6 : 0.7)
                        ], startPoint: .top, endPoint: .bottom
                    )
                )
                .blendMode(.overlay)
        )
    }
}

extension View {
    func strokeStyle(cornerRadius: CGFloat = 30) -> some View {
        modifier(StrokeModifier(cornerRadius: cornerRadius))
    }
}
