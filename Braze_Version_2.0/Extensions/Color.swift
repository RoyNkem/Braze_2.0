//
//  Color.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

extension Color {
    ///A custom theme that allows you add color palettes to your app
    static let theme = ColorTheme()
}

//MARK: - ColorTheme
struct ColorTheme {
    let accentColor = Color("AccentColor")
    let background = Color("BackgroundColor")
    let homeBackground = Color("HomeBackgroundColor")
    let green = Color("AppGreenColor")
    let red = Color("AppRedColor")
    let secondary = Color("SecondaryTextColor")
    let purple = Color("AppPurpleColor")
    let blue = Color("AppBlueColor")
    let increaseRate = Color("CoinIncreaseRateColor")
    let decreaseRate = Color("CoinDecreaseRateColor")
    let portfolio = Color("PortfolioColor")
    let appAccentColor = Color("AppAccent")
    let shadow = Color("Shadow")
//    let animationColorBackground = Color("AnimationColorBackground")
}
