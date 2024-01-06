//
//  ContentView.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: HealthKitManager
    var desiredAmountOfSleep = 8
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(String(manager.getSleepForLast7Days()))
        }
        .padding()
    }
}

#Preview {
    HomeView()
        .environmentObject(HealthKitManager())
        .environmentObject(SleepDebtSettings())
}
