//
//  Extension.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

extension View {
    ///A custom function that draws corner radius in any rectangle corner you so desire
    ///- Parameter radius: the
    /// - corners
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    //MARK: - isSmallHeight
    ///Checks the screen size of the phone running the app. Used together with other properties, modifiers and types to modify the screen content to adjust itself depending on the height.
    public func isSmallHeight() -> Bool {
        return UIScreen.main.bounds.height < 830
    }
    
    //MARK: - isSmallWidth
    ///Checks the screen size of the phone running the app. Used together with other properties, modifiers and types to modify the screen content to adjust itself depending on the width.
    public func isSmallWidth() -> Bool {
        return UIScreen.main.bounds.width <= 390
    }
    
}

extension UIApplication {
    
    func didEndEditing() {
        sendAction(#selector(UIApplication.shared.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
