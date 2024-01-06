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
    
    var sleepForLastXDays: Dictionary<Int, Int> = [:]
    
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
        self.getSleepForLastXDays(days: 7)
        self.getSleepForLastXDays(days: 30)
    }
    
    func getSleepForLast7Days() -> Int {
        self.getSleepForLastXDays(days: 7)
        return self.sleepForLastXDays[7] ?? 0
    }
    
    func getSleepForLast30Days() -> Int{
        self.getSleepForLastXDays(days: 30)
        return self.sleepForLastXDays[30] ?? 0
    }
    
    private func getSleepForLastXDays(days: Int) {
        var totalSleep = 0
        let sleep = HKCategoryType(.sleepAnalysis)
        let sleepPredicate = HKCategoryValueSleepAnalysis.predicateForSamples(equalTo: HKCategoryValueSleepAnalysis.allAsleepValues)
        let lastXDays = Date().addingTimeInterval(TimeInterval(-60 * 60 * 24 * days))
        
        let datePredicate = HKQuery.predicateForSamples(withStart: lastXDays, end: .now)
        let predicates = NSCompoundPredicate(andPredicateWithSubpredicates: [sleepPredicate, datePredicate])
        let sortByDate = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(
            sampleType: sleep,
            predicate: predicates,
            limit: 100000,
            sortDescriptors: [sortByDate])
        { _, results, error in
            for(_, sample) in results!.enumerated() {
                guard let currData:HKCategorySample = sample as? HKCategorySample else { print("There was an error"); return }
                
                let endDate = currData.endDate
                let startDate = currData.startDate
                let seconds = Int(endDate.timeIntervalSince(startDate))
                totalSleep += seconds
            }
            self.sleepForLastXDays[days] = totalSleep
        }
        healthStore.execute(query)
    }
}
