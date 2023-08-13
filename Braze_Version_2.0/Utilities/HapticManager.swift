//
//  HapticManager.swift
//  Braze
//
//  Created by Roy Aiyetin on 15/10/2022.
//

import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
