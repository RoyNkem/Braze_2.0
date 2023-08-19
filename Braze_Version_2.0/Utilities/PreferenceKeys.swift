//
//  PreferenceKeys.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

/**
 Custom preference key for tracking scroll offset.
 
 This preference key is used to store and propagate the scroll offset value throughout the SwiftUI view hierarchy.
 */
struct ScrollPreferenceKey: PreferenceKey {
    /// Default value for scroll offset.
    static var defaultValue: CGFloat = 0
    
    /**
     Combines and reduces scroll offset values.
     
     - Parameters:
        - value: The accumulated scroll offset value.
        - nextValue: A closure providing the next scroll offset value.
     */
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

/**
 Custom preference key for tracking circle dimensions.
 
 This preference key is used to store and propagate the dimensions of circles throughout the SwiftUI view hierarchy.
 */
struct CirclePreferenceKey: PreferenceKey {
    /// Default value for circle dimensions.
    static var defaultValue: CGFloat = 0
    
    /**
     Combines and reduces circle dimension values.
     
     - Parameters:
        - value: The accumulated circle dimension value.
        - nextValue: A closure providing the next circle dimension value.
     */
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

