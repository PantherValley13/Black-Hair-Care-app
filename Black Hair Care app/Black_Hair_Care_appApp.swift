//
//  Black_Hair_Care_appApp.swift
//  Black Hair Care app
//
//  Created by Darius Church on 2/25/25.
//

import SwiftUI

@main
struct BlackHairCareApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    
    init() {
        // Your existing initialization code here
    }
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                ContentView()
            } else {
                OnboardingView()
                    .onDisappear {
                        // Mark onboarding as completed when user proceeds to main app
                        hasCompletedOnboarding = true
                    }
            }
        }
    }
}
