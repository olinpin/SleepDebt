//
//  ContentView.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: HealthKitManager
    @EnvironmentObject var settings: SleepDebtSettings
    var desiredAmountOfSleep = 8
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(String(manager.sleepForLastXDays[settings.sleepDebtPeriod] ?? 0))
        }
        .padding()
        .onAppear {
            manager.updateSleep()
        }
        .onReceive(settings.$sleepDebtPeriod, perform: { _ in
            manager.updateSleep()
        })
    }
}

#Preview {
    HomeView()
        .environmentObject(HealthKitManager())
        .environmentObject(SleepDebtSettings())
}
