//
//  InputStyle.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

/// A custom SwiftUI view that provides a customizable visual effect overlay using `UIVisualEffectView`.
///
/// `VisualEffectView` wraps a `UIVisualEffectView`, allowing you to apply a blur or vibrancy effect to the content behind it.
/// Use this view to create a visually appealing and modern interface element that adds depth and style to your app.
///
/// Example usage:
///
/// ```
/// VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
///     .edgesIgnoringSafeArea(.all)
/// ```
struct VisualEffectView: UIViewRepresentable {
    /// The visual effect to apply to the overlay.
    var effect: UIVisualEffect?

    /// Creates the underlying `UIVisualEffectView` and configures its initial properties.
    /// - Parameter context: The context in which the view will be used.
    /// - Returns: An initialized `UIVisualEffectView` instance.
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView()
    }

    /// Updates the properties of the `UIVisualEffectView` when needed.
    /// - Parameters:
    ///   - uiView: The existing `UIVisualEffectView` instance.
    ///   - context: The context in which the view will be used.
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}

