//
//  SleepDebtTabView.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import SwiftUI

struct SleepDebtTabView: View {
    @State var selectedTab = "Home"
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            SettingsView()
                .tag("Settings")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    SleepDebtTabView()
        .environmentObject(SleepDebtSettings())
        .environmentObject(HealthKitManager())
}
