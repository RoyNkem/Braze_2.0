//
//  Braze_Version_2_0App.swift
//  Braze_Version_2.0
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

@main
struct Braze_Version_2_0App: App {
    @StateObject private var launchScreenManager = LaunchScreenStateManager()
    @StateObject private var vm = HomeViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoggedIn {
                    if launchScreenManager.state == .started {
                        // Show LaunchScreenView
                        LaunchScreenView()
                            .onAppear {
                                Task {
                                    launchScreenManager.dismiss()
                                }
                            }
                    } else {
                        NavigationView {
                            HomeView()
                                .navigationBarHidden(true)
                        }
                        .environmentObject(vm)
                    }
                } else {
                    // Show LoginView if user is not logged in and launch screen is finished
                    LoginView()
                        .environmentObject(vm)
                        .padding(.horizontal)
                }
            }
        }
    }
}

