//
//  HealthKitManager.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    init() {
        let sleep = HKCategoryType(.sleepAnalysis)
        
        let healthTypes: Set = [sleep]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print(error)
            }
        }
    }
    
    
}
