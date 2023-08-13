//
//  ScaledFont.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize)) 
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {

    func custom(font: CustomFont, size: CGFloat) -> some View {
        return scaledFont(name: font.rawValue, size: size)
    }

    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}

struct LibraryContent: LibraryContentProvider {
    
    @LibraryContentBuilder
    func modifiers(base: Text) -> [LibraryItem] {
        LibraryItem(
            base.custom(font: .bold, size: 24),
            title: "Custom Font",
            category: .other
        )
    }
}

enum CustomFont: String {
    case ultralight = "AvenirNextCondensed-UltraLight"
    case regular = "AvenirNextCondensed-Regular"
    case medium = "AvenirNextCondensed-Medium"
    case bold = "AvenirNextCondensed-Bold"
    case demibold = "AvenirNextCondensed-DemiBold"
    case heavy = "AvenirNextCondensed-Heavy"
}
