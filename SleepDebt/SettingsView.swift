//
//  SettingsView.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import SwiftUI

struct SettingsView: View {
    @State var sleepDebtPeriod = 30
    @State var repaymentPeriod = 7
    @State var desiredHoursOfSleep = 8
    @FocusState private var focusItem: Bool
    private var repaymentString = "Repayment period (days)"
    private var sleepDebtString = "Sleep debt period (days)"
    private var desiredHoursOfSleepString = "Desired hours of sleep"
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    SettingsNumberField(value: $sleepDebtPeriod, focusItem: $focusItem, text: sleepDebtString)
                    SettingsNumberField(value: $repaymentPeriod, focusItem: $focusItem, text: repaymentString)
                    SettingsNumberField(value: $desiredHoursOfSleep, focusItem: $focusItem, text: desiredHoursOfSleepString)
                }
                
            }
        .navigationTitle("Settings")
        }
        .onTapGesture{
            focusItem = false
        }
    }
    
    
}

#Preview {
    SettingsView()
}

struct SettingsNumberField: View {
    @Binding var value: Int
    var focusItem: FocusState<Bool>.Binding
    var text: String
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    var body: some View {
        LabeledContent {
            TextField("", value: $value, formatter: formatter)
                .keyboardType(.numberPad)
                .focused(focusItem)
                .multilineTextAlignment(.trailing)
                .foregroundStyle(.blue)
        } label: {
            Text(text)
                .fixedSize()
        }
    }
}
