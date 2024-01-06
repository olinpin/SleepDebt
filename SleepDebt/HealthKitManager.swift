//
//  HealthKitManager.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import Foundation
import HealthKit

extension Date {
    static var last7Days: Date {
        Date().addingTimeInterval(TimeInterval(-60 * 60 * 24 * 7)) // last 7 days
    }
}

class HealthKitManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    var sleepForLast7Days: Int = 0
    
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
        self.getSleepForLast7Days()
    }
    
    func getSleepForLast7Days() {
        var totalSleep = 0
        let sleep = HKCategoryType(.sleepAnalysis)
        let sleepPredicate = HKCategoryValueSleepAnalysis.predicateForSamples(equalTo: HKCategoryValueSleepAnalysis.allAsleepValues)
        let datePredicate = HKQuery.predicateForSamples(withStart: .last7Days, end: .now)
        let predicates = NSCompoundPredicate(andPredicateWithSubpredicates: [sleepPredicate, datePredicate])
        let sortByDate = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(
            sampleType: sleep,
            predicate: predicates,
            limit: 100000,
            sortDescriptors: [sortByDate])
        {_, results, error in
            for(_, sample) in results!.enumerated() {
                guard let currData:HKCategorySample = sample as? HKCategorySample else { print("There was an error"); return }
                
                let endDate = currData.endDate
                let startDate = currData.startDate
                let seconds = Int(endDate.timeIntervalSince(startDate))
                totalSleep += seconds
            }
            self.sleepForLast7Days = totalSleep
        }
        healthStore.execute(query)
    }
    
}
