//
////  LaunchScreenStateManager.swift
////  Braze_Version_2.0
////
////  Created by Roy's MacBook M1 on 18/08/2023.
////
//
import Foundation

/**
 Enum representing launch screen animation states.
 */
enum LaunchScreenAnimation {
    case started
    case finished
}

/**
 Manager class for launch screen animation state.
 */
final class LaunchScreenStateManager: ObservableObject {
    /// Current launch screen animation state.
    @MainActor @Published private(set) var state: LaunchScreenAnimation = .started
    
    /**
     Dismisses the launch screen animation after a delay.
     */
    @MainActor func dismiss() {
        Task {
            try? await Task.sleep(for: Duration.seconds(2.5))
            self.state = .finished
        }
    }
}
