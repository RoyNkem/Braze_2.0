//
//  Braze_Version_2_0App.swift
//  Braze_Version_2.0
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

@main
struct Braze_Version_2_0App: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm) // If a view uses an @EnvironmentObject, you must create the model object by calling the environmentObject(_:) modifier on an ancestor view. HomeView uses the ThingStore object, so you create it in BrazeApp.swift when it creates HomeView
        }
    }
}
