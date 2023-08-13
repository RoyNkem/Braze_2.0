//
//  ForegroundLinearGradient.swift
//  Braze
//
//  Created by Roy Aiyetin on 11/10/2022.
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
