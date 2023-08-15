//
////  CoinModel.swift
////  Braze_Version_2.0
////
////  Created by Roy's MacBook M1 on 13/08/2023.
////
//
import Foundation
//

enum LaunchScreenAnimation {
    case started
    case finished
}

final class LaunchScreenStateManager: ObservableObject {
    @MainActor @Published private(set) var state: LaunchScreenAnimation = .started
    
    @MainActor func dismiss() {
        Task {
            try? await Task.sleep(for: Duration.seconds(2.5))
            self.state = .finished
        }
    }
}
