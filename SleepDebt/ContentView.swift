//
//  ContentView.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: HealthKitManager
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button(action: {
                manager.getSleepForLast7Days()
                print(manager.sleepForLast7Days)
                var seconds = manager.sleepForLast7Days
                print("hours: ", seconds / 3600, " minutes: ", (seconds % 3600) / 60, " seconds: ", (seconds % 3600) % 60)
            }) {
                Text("Hello, world!")
            }
        }
        .padding()
        .onAppear {
            manager.getSleepForLast7Days()
            print(manager.sleepForLast7Days)
            var seconds = manager.sleepForLast7Days
            print("hours: ", seconds / 3600, " minutes: ", (seconds % 3600) / 60, " seconds: ", (seconds % 3600) % 60)
            
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(HealthKitManager())
}
