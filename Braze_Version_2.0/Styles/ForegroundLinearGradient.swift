//
//  ForegroundLinearGradient.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

extension View { // Gradient for navigation bar
    public func foregroundLinearGradient(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> some View {
        self.overlay(
        LinearGradient(colors: colors, startPoint: startPoint, endPoint: endPoint)
            .mask(self)
        )
    }
}
