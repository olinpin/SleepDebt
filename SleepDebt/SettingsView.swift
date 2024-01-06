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
    @FocusState private var focusItem: Bool
    private var repaymentString = "Repayment period (days)"
    private var sleepDebtString = "Sleep debt period (days)"
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            
            List {
                Section {
                    LabeledContent {
                        TextField("", value: $sleepDebtPeriod, formatter: formatter)
                            .keyboardType(.numberPad)
                            .onSubmit {
                                focusItem = false
                            }
                            .focused($focusItem)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.blue)
                    } label: {
                        Text(sleepDebtString)
                            .fixedSize()
                    }
                    
                    .lineLimit(1)
                    LabeledContent {
                        TextField("", value: $repaymentPeriod, formatter: formatter)
                            .keyboardType(.numberPad)
                            .onSubmit {
                                focusItem = false
                            }
                            .focused($focusItem)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.blue)
                        
                    } label: {
                        Text(repaymentString)
                            .fixedSize()
                    }
                }
            }
            .onTapGesture{
                focusItem = false
            }
            .navigationTitle("Settings")
        }
        
        
    }
}

#Preview {
    SettingsView()
}
