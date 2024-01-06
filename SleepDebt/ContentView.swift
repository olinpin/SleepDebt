//
//  ContentView.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: HealthKitManager
    var desiredAmountOfSleep = 8
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
//            Button(action: {
//                print(manager.sleepForLastXDays)
//            var seconds = Int(manager.getSleepForLast7Days())
//            print("hours: ", seconds / 3600, " minutes: ", (seconds % 3600) / 60, " seconds: ", (seconds % 3600) % 60)
//            seconds = Int(manager.getSleepForLast30Days())
//            print("hours: ", seconds / 3600, " minutes: ", (seconds % 3600) / 60, " seconds: ", (seconds % 3600) % 60)
//            }) {
//                Text("Hello, world!")
//            }
        }
        .padding()
//        .onAppear {
//            print(manager.sleepForLastXDays)
//            var seconds = Int(manager.getSleepForLast7Days())
//            print("hours: ", seconds / 3600, " minutes: ", (seconds % 3600) / 60, " seconds: ", (seconds % 3600) % 60)
//            seconds = Int(manager.getSleepForLast30Days())
//            print("hours: ", seconds / 3600, " minutes: ", (seconds % 3600) / 60, " seconds: ", (seconds % 3600) % 60)
//        }
    }
}

#Preview {
    ContentView()
        .environmentObject(HealthKitManager())
}
