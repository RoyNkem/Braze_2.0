//
//  LaunchScreenStateManager.swift
//  Braze_Version_2.0
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import Foundation


enum LaunchScreenStep {
    case firstStep
    case secondStep
    case finished
}

final class LaunchScreenStateManager: ObservableObject {
    @MainActor @Published private(set) var state: LaunchScreenStep = .firstStep
    
    @MainActor func dismiss() {
        Task {
            state = .secondStep
            try? await Task.sleep(for: Duration.seconds(2))
            self.state = .finished
        }
    }
}
