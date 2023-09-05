//
//  GreetingViewModel.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 05/09/2023.
//

import Foundation
import SwiftUI

class GreetingViewModel: ObservableObject {
    @Published var greeting = ""

    // Define the hours to update the greeting
    let morningHour = 0
    let afternoonHour = 12
    let eveningHour = 18

    init() {
        // Start a timer to update the greeting at appropriate hours
        updateGreeting()
        Timer.scheduledTimer(withTimeInterval: 600, repeats: true) { _ in
            self.updateGreeting()
        }
    }

    func updateGreeting() {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: Date())

        if hour >= morningHour && hour < afternoonHour {
            greeting = "Good morning"
        } else if hour >= afternoonHour && hour < eveningHour {
            greeting = "Good afternoon"
        } else {
            greeting = "Good evening"
        }
    }
}

