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
    var body: some View {
        ZStack {
            LazyHGrid(rows: Array(repeating: GridItem(spacing: 20), count: 2)) {
                CardView(
                    topText: "Your sleep debt for the last \(settings.sleepDebtPeriod.rawValue) days is",
                    value: self.getTotalSleepDebt(),
                    image: "moon.zzz")
                CardView(topText: "You should sleep at least",
                         value: self.getDailyRepaymentSleep(),
                         image: "moon.zzz.fill",
                         bottomText: "per day to catch up on your sleep in \(settings.repaymentPeriod) days")
            }
            .padding(.horizontal)
        }
        .padding()
        .onAppear {
            manager.updateSleep()
        }
        .onReceive(settings.$sleepDebtPeriod, perform: { _ in
            manager.updateSleep()
        })
    }
    
    private func getTotalSleepDebt() -> Int {
        let totalSleep = manager.sleepForLastXDays[settings.sleepDebtPeriod] ?? 0
        let desiredSleep = settings.desiredHoursOfSleep * settings.sleepDebtPeriod.rawValue * 60 * 60
        return max(desiredSleep - totalSleep, 0)
    }
    
    private func getDailyRepaymentSleep() -> Int {
        let sleepDebtPerDay = self.getTotalSleepDebt() / settings.repaymentPeriod
        return settings.desiredHoursOfSleep * 60 * 60 + sleepDebtPerDay
    }
}

#Preview {
    HomeView()
        .environmentObject(HealthKitManager())
        .environmentObject(SleepDebtSettings())
    
}
