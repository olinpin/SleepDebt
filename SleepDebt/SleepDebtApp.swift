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
    var body: some Scene {
        WindowGroup {
            SleepDebtTabView()
                .environmentObject(healthKitManager)
        }
    }
}
