//
//  SleepDebtTabView.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import SwiftUI

struct SleepDebtTabView: View {
    @State var selectedTab = "Home"
    @StateObject var healthKitManager = HealthKitManager()
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .environmentObject(healthKitManager)
            SettingsView()
                .tag("Settings")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .environmentObject(healthKitManager)
        }
    }
}

#Preview {
    SleepDebtTabView()
}
