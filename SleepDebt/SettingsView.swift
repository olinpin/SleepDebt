//
//  SettingsView.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SleepDebtSettings
    @FocusState private var focusItem: Bool
    private var repaymentString = "Repayment period (days)"
    private var sleepDebtString = "Sleep debt period (days)"
    private var desiredHoursOfSleepString = "Desired hours of sleep"
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    SettingsNumberFieldView(value: $settings.sleepDebtPeriod, focusItem: $focusItem, text: sleepDebtString)
                    SettingsNumberFieldView(value: $settings.repaymentPeriod, focusItem: $focusItem, text: repaymentString)
                    SettingsNumberFieldView(value: $settings.desiredHoursOfSleep, focusItem: $focusItem, text: desiredHoursOfSleepString)
                }
                
            }
        .navigationTitle("Settings")
        }
        .onTapGesture{
            focusItem = false
        }
        .environmentObject(settings)
    }
    
    
}

#Preview {
    SettingsView()
        .environmentObject(HealthKitManager())
        .environmentObject(SleepDebtSettings())
}

