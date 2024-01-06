//
//  SettingsNumberFieldView.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import SwiftUI

struct SettingsNumberFieldView: View {
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

struct SettingsNumberFieldView_Preview: PreviewProvider {
    
    struct ContainerView: View {
        @State var sleepDebtPeriod = 30
        @FocusState var focusItem: Bool
        var sleepDebtString = "Sleep debt period (days)"
        var body: some View {
            SettingsNumberFieldView(value: $sleepDebtPeriod, focusItem: $focusItem, text: sleepDebtString)
        }
    }
    static var previews: some View {
        ContainerView()
    }
}
