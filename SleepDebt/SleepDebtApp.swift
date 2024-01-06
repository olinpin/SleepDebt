//
//  SleepDebtApp.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import SwiftUI

@main
struct SleepDebtApp: App {
    @StateObject var healthKitManager = HealthKitManager()
    @StateObject var settings = SleepDebtSettings()
    var body: some Scene {
        WindowGroup {
            SleepDebtTabView()
                .environmentObject(healthKitManager)
                .environmentObject(settings)
                .preferredColorScheme(.dark)

        }
    }
}

class SleepDebtSettings: ObservableObject {
    @Published var sleepDebtPeriod = Days.thirty
    @Published var repaymentPeriod = 7
    @Published var desiredHoursOfSleep = 8
}
